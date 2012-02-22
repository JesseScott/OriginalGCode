

//-----------------------------------------------------------------------------------------
// Parse Blob Vertices to GML via xml file

 void gml() {	
   if (detect == true) {
     Blob b;
     EdgeVertex gmlA,gmlB;
     for (int n = 0 ; n < theBlobDetection.getBlobNb() ; n++) {
       if (blbs[n] == true){
         b = theBlobDetection.getBlob(n);
	 if (b!=null) {
	   for (int m = 0; m < b.getEdgeNb(); m++) {
             gmlA = b.getEdgeVertexA(m);
	     gmlB = b.getEdgeVertexB(m);
	       if (gmlA != null && gmlB != null) {
                 if(export == true) {
                   frameRate(1);
                   // Subtract 1 to flip horizontal
                   Vec3D v = new Vec3D((float) 1 - gmlA.x, (float) gmlA.y, 0);
                   // <pt>v</pt> (add point tag)
                   recorder.addPoint(0, v, 0.1);     
                 } 
                 frameRate(30);
	       }             
           }
           // </stroke> (End Stroke)
           recorder.endStroke(0);
           // <stroke layer="0"> (Start New Stroke)
           GmlBrush brush = new GmlBrush();
           brush.set(GmlBrush.UNIQUE_STYLE_ID, MeshDemo.ID); 
           recorder.beginStroke(0, 0, brush);
	 }       
       } 
     } 
   }    
 } 

//-----------------------------------------------------------------------------------------
