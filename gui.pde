
//-----------------------------------------------------------------------------------------
// Labels, etc. 

public void labels() {

  // Text
  textFont(font, 16);
  text("ORIGINAL G-CODE ", 1150, 700);
  text("...from your friends at GRL Germany", 1150, 730);
  text("CTRL", 725, 90);
  text("PREVIEW", width-710, 550);
  text("OUTPUT", 50, 550);
  text("OPTIONS", 725, 275);
  
  logo = loadImage("grlBerlin.gif");
  image(logo, 900, height-250);
} 

//-----------------------------------------------------------------------------------------
