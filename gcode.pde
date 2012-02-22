

//-----------------------------------------------------------------------------------------
// Parse Blob Vertices to GCode via txt file

 void gc() {	
   if (detect == true) {
     Blob b;
     EdgeVertex gcA,gcB;
     for (int n = 0 ; n < theBlobDetection.getBlobNb() ; n++) {
       if (blbs[n] == true){
         b = theBlobDetection.getBlob(n);
	   if (b!=null) {
	     for (int m = 0; m < b.getEdgeNb(); m++) {
               gcA = b.getEdgeVertexA(m);
	       gcB = b.getEdgeVertexB(m);
	         if (gcA != null && gcB != null) {
                   if(export == true) {
                     frameRate(1);
                     // Mirror Horizontal
                     float revX = 1 - gcA.x; 
                     // XY
                     if(m == 0) {
                       // Move to the First Point
                       output.println("G0" + " " + "X " + revX * cam.width + " " + "Y " + gcA.y * cam.height);
                       // Move Laser Down
                       output.println("G1 Z " + gcZDN);
                       // Set Feed Rate of CNC
                       output.println("F" + gcFeed); 
                     }
                     else if(m > 0) {
                       // This is the main body of the path
                       output.println("G1" + " " + "X " + revX * cam.width + " " + "Y " + gcA.y * cam.height); 
                     }  
                   }
                   frameRate(30);
		 }
             } 
             // Bring Laser Up
             output.println("G1 Z " + gcZUP);
             output.println("G0 Z " + gcZUP);
             output.println(" "); // Give a space so we can easily read where shapes end
	   }         
       } 
     } 
   }   
 } 

//-----------------------------------------------------------------------------------------
