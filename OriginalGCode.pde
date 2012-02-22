

  //-----------------------------------------------------------------------------------------
  /*
  
   This work is licensed under the Creative Commons Attribution-NonCommercial-Repurcusssions 3.0 Unported License. 
   To view a copy of this license, visit http://www.graffitiresearchlab.fr/?portfolio=attribution-noncommercial-repercussions-3-0-unported-cc-by-nc-3-0
  
   ORIGINAL G-CODE
  
   Graffiti Research Lab Germany  
   http://www.graffitiresearchlab.de/original-gcode/
   
   Processing 1.5.1
  
   BlobDetection Library by v3ga <http://processing.v3ga.net>
   GML4U Library by Jérôme Saint-Clair <http://www.saint-clair.net/gml-gml4u/>
   ControlP5 Library by Andreas Schlegel <http://www.sojamo.de/libraries/controlP5/>
   Super Fast Blur v1.1 by Mario Klingemann  <http://incubator.quasimondo.com>
  
  */
  //-----------------------------------------------------------------------------------------

  // LIBRARY IMPORTS
  import blobDetection.*;
  import processing.dxf.*;
  import processing.pdf.*;
  import processing.opengl.*;
  import controlP5.*;
  import processing.video.*;

  import gml4u.drawing.GmlBrushManager;
  import gml4u.events.GmlEvent;
  import gml4u.model.GmlBrush;
  import gml4u.brushes.*;
  import gml4u.model.GmlConstants;
  import gml4u.model.GmlStroke;
  import gml4u.model.Gml;
  import gml4u.recording.GmlRecorder;
  import gml4u.utils.GmlSaver;
  import toxi.geom.Vec3D;
  
  // CLASS DECLARATION
  BlobDetection theBlobDetection;
  ControlP5 controlP5;
  Capture cam;
  PrintWriter output;
  GmlRecorder recorder;
  GmlSaver saver;
  GmlBrushManager brushes = new GmlBrushManager();
  GmlBrushManager brushManager;
  XMLElement xml;

  // VARIABLE DECLARATIONS
  PFont font; // For drawign GUI
  PImage img; // Detected Blobs
  PImage logo; // Logo
  boolean newFrame = false; // Video Capture

  
  // GUI Variables for Controlling Export Options
  boolean detect = false;
  boolean export = false;
  boolean clear = false;
  boolean saveDXF = false;
  boolean saveJPG = false;
  boolean saveGMLf = false;
  boolean saveGMLw = false;
  boolean saveGCODE = false;
  float gcFeed, gcZUP, gcZDN;
  
  // An Array of Blobs that we can turn off
  boolean[] blbs = {true,true,true,true,true,true,true,true,true,true,true,true,
                    true,true,true,true,true,true,true,true,true,true,true,true,
                    true,true,true,true,true,true,true,true,true,true,true,true,
                    true,true,true,true,true,true,true,true,true,true,true,true,
                    true,true,true,true,true,true,true,true,true,true,true,true,
                    true,true,true,true,true,true,true,true,true,true,true,true,
                    true,true,true,true,true,true,true,true,true,true,true,true,
                    true,true,true,true,true,true,true,true,true,true,true,true,
                    true,true,true,true,true,true,true,true,true,true,true,true,
                    true,true,true,true,true,true,true,true,true,true,true,true,
                    true,true,true,true,true,true,true,true,true,true,true,true,
                    true,true,true,true,true,true,true,true,true,true,true,true,
                    true,true,true,true,true,true,true,true,true,true,true,true};
  
  float thresh = 0.24; // Threshold of Blob Detection
  int blurVal = 1; // Default Blur Amount
  float scale; // To remap normalized GML values <screenScale></screenScale>
  int exportCounter = 0; // To Iterate Exports, so we dont Overwrite
  int id, camID; String name, attribute; // XML Variables from settings.xml

  //-----------------------------------------------------------------------------------------
  
  void setup() {
    // Screen stuff
    // Capture.list(); // OPENGL workaround
    String[] devices = Capture.list();
    // println(devices);
    size(1600,800,OPENGL);
    background(0);
     
    // XML
    xml = new XMLElement(this, "settings.xml"); // load our settings
    int numTags = xml.getChildCount();
    for(int i = 0; i < numTags; i++) {
      XMLElement kid = xml.getChild(i);
      int id = kid.getInt("id");
      // Overly cautious, but making sure mistaked editing wont destroy parsing...
      if(id == 0) { // 1st tag
        name = kid.getString("name"); // 'camera'
      }
      if(name.equals("camera")) {
        attribute = kid.getContent(); // number
      }
    }
    int camID = int(attribute); // convert our parsed string to an int

    // Capture
    cam = new Capture(this, 640, 480, devices[camID]); // device id will change per machine 
    img = new PImage(320,240);
     
    // Blob Detection
    theBlobDetection = new BlobDetection(img.width, img.height);
    theBlobDetection.setPosDiscrimination(true);

    // Font
    font = createFont("Verdana", 18);
    
    // Writer
    //output = createWriter("exports/GCode.txt"); // moved to control tab

    // Draw Labels
    labels();
   
   // GML Recorder
    Vec3D screen = new Vec3D(cam.width, cam.height, 0);
    brushManager = new GmlBrushManager();
    scale = 640;
    recorder = new GmlRecorder(screen, 0.015f, 0.01f);
    saver = new GmlSaver(500, "", this);
    saver.start();
  
    // CP5
     controlP5 = new ControlP5(this);
     // CTRL
     controlP5.addSlider("THRESHOLD",0,1,0.14, 725, 100, 100, 20);
     controlP5.addSlider("BLUR_VALUE",1,10,1, 725, 130, 100, 20);
     // EXPORT OPTIONS
     controlP5.addToggle("DETECT",false,725,200,30,30);
     controlP5.addBang("EXPORT",785,200,30,30);
     controlP5.addToggle("DXF", false,725,285,20,20);
     controlP5.addToggle("JPG", false,785,285,20,20);
     controlP5.addToggle("GML_FILE",false,725,325,20,20);
     controlP5.addToggle("GML_WEB",false,785,325,20,20);
     controlP5.addToggle("GCODE", false, 725,365,20,20);
     controlP5.addSlider("FEEDRATE",50,500,120,725,400,100,20);
     controlP5.addSlider("Z_UP",-5,5,0,725,430,100,20);
     controlP5.addSlider("Z_DOWN",-5,5,0,725,460,100,20);
     // BLOB TOGGLE
     ControlGroup bl = controlP5.addGroup("BLOBS", 50, 575, 300);
     controlP5.addToggle("_00",false,0,10,20,20).setGroup(bl);
     controlP5.addToggle("_01",false,25,10,20,20).setGroup(bl);
     controlP5.addToggle("_02",false,50,10,20,20).setGroup(bl);
     controlP5.addToggle("_03",false,75,10,20,20).setGroup(bl);
     controlP5.addToggle("_04",false,100,10,20,20).setGroup(bl);
     controlP5.addToggle("_05",false,125,10,20,20).setGroup(bl);
     controlP5.addToggle("_06",false,150,10,20,20).setGroup(bl);
     controlP5.addToggle("_07",false,175,10,20,20).setGroup(bl);
     controlP5.addToggle("_08",false,200,10,20,20).setGroup(bl);
     controlP5.addToggle("_09",false,225,10,20,20).setGroup(bl);
     controlP5.addToggle("_10",false,250,10,20,20).setGroup(bl);
     controlP5.addToggle("_11",false,275,10,20,20).setGroup(bl);
     controlP5.addToggle("_12",false,0,50,20,20).setGroup(bl);
     controlP5.addToggle("_13",false,25,50,20,20).setGroup(bl);
     controlP5.addToggle("_14",false,50,50,20,20).setGroup(bl);
     controlP5.addToggle("_15",false,75,50,20,20).setGroup(bl);
     controlP5.addToggle("_16",false,100,50,20,20).setGroup(bl);
     controlP5.addToggle("_17",false,125,50,20,20).setGroup(bl);
     controlP5.addToggle("_18",false,150,50,20,20).setGroup(bl);
     controlP5.addToggle("_19",false,175,50,20,20).setGroup(bl);
     controlP5.addToggle("_20",false,200,50,20,20).setGroup(bl);
     controlP5.addToggle("_21",false,225,50,20,20).setGroup(bl);
     controlP5.addToggle("_22",false,250,50,20,20).setGroup(bl);
     controlP5.addToggle("_23",false,275,50,20,20).setGroup(bl);  
     controlP5.addToggle("_24",false,0,90,20,20).setGroup(bl);
     controlP5.addToggle("_25",false,25,90,20,20).setGroup(bl);
     controlP5.addToggle("_26",false,50,90,20,20).setGroup(bl);
     controlP5.addToggle("_27",false,75,90,20,20).setGroup(bl);
     controlP5.addToggle("_28",false,100,90,20,20).setGroup(bl);
     controlP5.addToggle("_29",false,125,90,20,20).setGroup(bl);
     controlP5.addToggle("_30",false,150,90,20,20).setGroup(bl);
     controlP5.addToggle("_31",false,175,90,20,20).setGroup(bl);
     controlP5.addToggle("_32",false,200,90,20,20).setGroup(bl);
     controlP5.addToggle("_33",false,225,90,20,20).setGroup(bl);
     controlP5.addToggle("_34",false,250,90,20,20).setGroup(bl);
     controlP5.addToggle("_35",false,275,90,20,20).setGroup(bl);   
    
  } // end Setup

  //-----------------------------------------------------------------------------------------

  void captureEvent(Capture cam) {
	cam.read(); // read a new frame from the camera
	newFrame = true;
  } // end captureEvent

  //-----------------------------------------------------------------------------------------
  
  void draw() {
    background(0);
    labels();       
    //int fps = round(frameRate); println(fps);

    // GUI adjustments (the rest is in the control tab)
    theBlobDetection.setThreshold(thresh);
    
    // Video Windows 
    noFill();
    strokeWeight(2);
    stroke(255);

    // Preview Window
    pushMatrix();
      scale(-1,1);
      translate(-890-320,-50-241);
      translate(-890-320,50+241);
      rect(889, 49, 642, 482);
      image(cam,890,50,640,480);  // Preview
    popMatrix();
    // Effect Window 
    rect(50, 50, 640, 480);
    img.copy(cam, 0, 0, cam.width, cam.height, 0,0, img.width, img.height); // Output        
    
    // Start Exporting  
    if (export == true) {
      println("EXPORTING AT FRAME " + frameCount);
      if(saveDXF == true) {
        println("SAVING DXF FILE");
        beginRaw(DXF, "exports/output_" + exportCounter + ".dxf");
      }
    }
    
    
    // draw stuff	
    if (newFrame == true) {
      newFrame = false;
      fastblur(img, blurVal); // apply blur to soften the image
      pushMatrix();
        scale(-1,1); // mirror it for reference
        translate(-50-320,-50-241); 
        translate(-50-320,50+241);      	
        theBlobDetection.computeBlobs(img.pixels); // compute the blobs
        translate(50,50);	// offset from corner
        drawBlobsAndEdges(false ,true); // draw the blobs (and not the bounding rects)
      popMatrix();
    }
    
    // Start Exporting  
    if (export == true) {
      println("EXPORTING AT FRAME " + frameCount);
      if(saveJPG == true) {
        println("SAVING JPG SCREENSHOT");
        saveFrame("exports/output_" + exportCounter + ".jpg");
      }
      if(saveGMLf == true) {
        println("SAVING GML FILE");
        gml();
        recorder.endStroke(0); 
        saver.save(recorder.getGml(), sketchPath + "/exports/gml_" + exportCounter + ".xml");
      }
      if(saveGMLw == true) {
        println("SAVING GML TO 000000BOOK.COM");
        // upload to 000000book.com 
      }
      if(saveGCODE == true) {
        println("SAVING GCODE");
        gc();
        output.flush();
        output.close();  
      }
    }
    
    // Stop Exporting
    if (export == true) {
      endRaw();
      export = false;
      println("STOPPING AT FRAME " + frameCount);
     }
     
     controlP5.draw();
     
   } // end Draw

  //-----------------------------------------------------------------------------------------


