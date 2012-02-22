
//-----------------------------------------------------------------------------------------

 void drawBlobsAndEdges(boolean drawBlobs, boolean drawEdges) {
	
  if (detect == true) {
    //noFill();
    Blob b;
    EdgeVertex eA,eB;
      for (int n = 0 ; n < theBlobDetection.getBlobNb() ; n++) {
        if (blbs[n] == true){
	  b = theBlobDetection.getBlob(n);
	  if (b!=null) {
            // Edges
	    if (drawEdges) {
	      strokeWeight(2);
	      stroke(0, 255, 0);
              beginShape();
	       for (int m = 0; m < b.getEdgeNb(); m++) {
		 eA = b.getEdgeVertexA(m);
		 eB = b.getEdgeVertexB(m);
		   if (eA != null && eB != null) {
	             vertex(eA.x * cam.width, eA.y * cam.height);
		   }
               }
              endShape(CLOSE);    
	    }          
	    // Blobs
	    if (drawBlobs) {
	     // N/A
	    }
	  }
          // Draw the Number of the Blob so that we can turn it off
          if(export == false) {
            fill(255,255,255);
            font = createFont("Verdana", 12);
            pushMatrix();
              scale(-1, 1);
              translate(-50 -320, -50 -241);
              translate(-50 -320, 50 +241);
              text(n, 50 + b.xMin * cam.width, 50 + b.yMin * cam.height);
            popMatrix();
            noFill();
          }
        }
      } // end n++
  } // detect
  
} // end drawBlobs

//-----------------------------------------------------------------------------------------
