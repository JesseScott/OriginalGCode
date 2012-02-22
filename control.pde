 
 //-----------------------------------------------------------------------------------------
 // CTRL 
  
 void THRESHOLD(float threshValue) {
    thresh = (threshValue); // Threshold of the Blob Detection
  }
  
 void BLUR_VALUE(int blurValue) {
    blurVal = (blurValue); // Amount of Blur to soften lines
  }
  
  
  //-----------------------------------------------------------------------------------------
  // EXPORT
  
  public void controlEvent(ControlEvent theEvent) {
    if (theEvent.isGroup()){
    }
    else if (theEvent.isController()){
    }
  }
  
  public void DETECT(boolean theFlag) {
    detect =! detect; // Turn On/Off Blob Detection
  }
  
  public void EXPORT(boolean theFlag) {
    if(theFlag == true) {
      // increase export counter to keep track of files
      exportCounter ++;
      // new GML brush
      GmlBrush brush = new GmlBrush();
      brush.set(GmlBrush.UNIQUE_STYLE_ID, MeshDemo.ID); 
      recorder.beginStroke(0, 0, brush); 
      // new GCode file
      output = createWriter("exports/GCode_" + exportCounter + ".txt");
      // prepend GCode file
      output.println("(ORIGINAL G-CODE)");
      output.println("(GRAFFITI RESEARCH LAB GERMANY)");
      output.println("G21 (Set Pixels to Unit in mm)");
      output.println("G90 (Absolute distance mode)");
      output.println("G64 P0.01 (Exact Path 0.001 tol.)");
      output.println("G17 (XY Plane Selection)");
      output.println(" ");
      output.println("G0 Z " + gcZUP);
      output.println(" ");
      // start to export
      export = true;
    }
  }

  
  //-----------------------------------------------------------------------------------------
  // SAVE OPTIONS
  
  public void DXF(boolean theFlag) {
    if(theFlag == true) {
      saveDXF = true;
    } else if (theFlag == false) {
      saveDXF = false;
    }
  }

  public void JPG(boolean theFlag) {
    if(theFlag == true) {
      saveJPG = true;
    } else if (theFlag == false) {
      saveJPG = false;
    }
  }

  public void GML_FILE(boolean theFlag) {
    if(theFlag == true) {
      saveGMLf = true;
    } else if (theFlag == false) {
      saveGMLf = false;
    }
  }
 
  public void GML_WEB(boolean theFlag) {
    if(theFlag == true) {
      saveGMLw = true;
    } else if (theFlag == false) {
      saveGMLw = false;
    }
  }

  public void GCODE(boolean theFlag) {
    if(theFlag == true) {
      saveGCODE = true;
    } else if (theFlag == false) {
      saveGCODE = false;
    }
  }
  
  void FEEDRATE(float feedValue) {
    gcFeed = (feedValue);
  }
  
  void Z_UP(float zupValue) {
    gcZUP = (zupValue);
  }
  
  void Z_DOWN(float zdnValue) {
    gcZDN = (zdnValue);
  }
  
  //-----------------------------------------------------------------------------------------
  // BLOBS
  
  public void _00(boolean theFlag) {
    if(theFlag == true) {
      blbs[0] = false;
    } else if (theFlag == false) {
      blbs[0] = true;
    }
  }
  
  public void _01(boolean theFlag) {
    if(theFlag == true) {
      blbs[1] = false;
    } else if (theFlag == false) {
      blbs[1] = true;
    }
  }
  
  public void _02(boolean theFlag) {
    if(theFlag == true) {
      blbs[2] = false;
    } else if (theFlag == false) {
      blbs[2] = true;
    }
  }
  
  public void _03(boolean theFlag) {
    if(theFlag == true) {
      blbs[3] = false;
    } else if (theFlag == false) {
      blbs[3] = true;
    }
  }
  
    public void _04(boolean theFlag) {
    if(theFlag == true) {
      blbs[4] = false;
    } else if (theFlag == false) {
      blbs[4] = true;
    }
  }
  
  public void _05(boolean theFlag) {
    if(theFlag == true) {
      blbs[5] = false;
    } else if (theFlag == false) {
      blbs[5] = true;
    }
  }
  
  public void _06(boolean theFlag) {
    if(theFlag == true) {
      blbs[6] = false;
    } else if (theFlag == false) {
      blbs[6] = true;
    }
  }
  
  public void _07(boolean theFlag) {
    if(theFlag == true) {
      blbs[7] = false;
    } else if (theFlag == false) {
      blbs[7] = true;
    }
  }
  
  public void _08(boolean theFlag) {
    if(theFlag == true) {
      blbs[8] = false;
    } else if (theFlag == false) {
      blbs[8] = true;
    }
  }
  
  public void _09(boolean theFlag) {
    if(theFlag == true) {
      blbs[9] = false;
    } else if (theFlag == false) {
      blbs[9] = true;
    }
  }
  
  public void _10(boolean theFlag) {
    if(theFlag == true) {
      blbs[10] = false;
    } else if (theFlag == false) {
      blbs[10] = true;
    }
  }
  
  public void _11(boolean theFlag) {
    if(theFlag == true) {
      blbs[11] = false;
    } else if (theFlag == false) {
      blbs[11] = true;
    }
  }
  
///// Row 2
    
  public void _12(boolean theFlag) {
    if(theFlag == true) {
      blbs[12] = false;
    } else if (theFlag == false) {
      blbs[12] = true;
    }
  }
    
  public void _13(boolean theFlag) {
    if(theFlag == true) {
      blbs[13] = false;
    } else if (theFlag == false) {
      blbs[13] = true;
    }
  }
    
  public void _14(boolean theFlag) {
    if(theFlag == true) {
      blbs[14] = false;
    } else if (theFlag == false) {
      blbs[14] = true;
    }
  }
  
  public void _15(boolean theFlag) {
    if(theFlag == true) {
      blbs[15] = false;
    } else if (theFlag == false) {
      blbs[15] = true;
    }
  }
  
  public void _16(boolean theFlag) {
    if(theFlag == true) {
      blbs[16] = false;
    } else if (theFlag == false) {
      blbs[16] = true;
    }
  }
    
  public void _17(boolean theFlag) {
    if(theFlag == true) {
      blbs[17] = false;
    } else if (theFlag == false) {
      blbs[17] = true;
    }
  }
    
  public void _18(boolean theFlag) {
    if(theFlag == true) {
      blbs[18] = false;
    } else if (theFlag == false) {
      blbs[18] = true;
    }
  }
  
  public void _19(boolean theFlag) {
    if(theFlag == true) {
      blbs[19] = false;
    } else if (theFlag == false) {
      blbs[19] = true;
    }
  }
  
  public void _20(boolean theFlag) {
    if(theFlag == true) {
      blbs[20] = false;
    } else if (theFlag == false) {
      blbs[20] = true;
    }
  }
    
  public void _21(boolean theFlag) {
    if(theFlag == true) {
      blbs[21] = false;
    } else if (theFlag == false) {
      blbs[21] = true;
    }
  }
    
  public void _22(boolean theFlag) {
    if(theFlag == true) {
      blbs[22] = false;
    } else if (theFlag == false) {
      blbs[22] = true;
    }
  }
  
  public void _23(boolean theFlag) {
    if(theFlag == true) {
      blbs[23] = false;
    } else if (theFlag == false) {
      blbs[23] = true;
    }
  }
  
///// Row 3
    
  public void _24(boolean theFlag) {
    if(theFlag == true) {
      blbs[24] = false;
    } else if (theFlag == false) {
      blbs[24] = true;
    }
  }
    
  public void _25(boolean theFlag) {
    if(theFlag == true) {
      blbs[25] = false;
    } else if (theFlag == false) {
      blbs[25] = true;
    }
  }
    
  public void _26(boolean theFlag) {
    if(theFlag == true) {
      blbs[26] = false;
    } else if (theFlag == false) {
      blbs[26] = true;
    }
  }
  
  public void _27(boolean theFlag) {
    if(theFlag == true) {
      blbs[27] = false;
    } else if (theFlag == false) {
      blbs[27] = true;
    }
  }
  
  public void _28(boolean theFlag) {
    if(theFlag == true) {
      blbs[28] = false;
    } else if (theFlag == false) {
      blbs[28] = true;
    }
  }
    
  public void _29(boolean theFlag) {
    if(theFlag == true) {
      blbs[29] = false;
    } else if (theFlag == false) {
      blbs[29] = true;
    }
  }
    
  public void _30(boolean theFlag) {
    if(theFlag == true) {
      blbs[30] = false;
    } else if (theFlag == false) {
      blbs[30] = true;
    }
  }
  
  public void _31(boolean theFlag) {
    if(theFlag == true) {
      blbs[31] = false;
    } else if (theFlag == false) {
      blbs[31] = true;
    }
  }
  
  public void _32(boolean theFlag) {
    if(theFlag == true) {
      blbs[32] = false;
    } else if (theFlag == false) {
      blbs[32] = true;
    }
  }
    
  public void _33(boolean theFlag) {
    if(theFlag == true) {
      blbs[30] = false;
    } else if (theFlag == false) {
      blbs[30] = true;
    }
  }
    
  public void _34(boolean theFlag) {
    if(theFlag == true) {
      blbs[34] = false;
    } else if (theFlag == false) {
      blbs[34] = true;
    }
  }
  
  public void _35(boolean theFlag) {
    if(theFlag == true) {
      blbs[35] = false;
    } else if (theFlag == false) {
      blbs[35] = true;
    }
  }
