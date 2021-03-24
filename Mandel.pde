Palette palette=new Palette(250);
Mandelbrot m;
double zoomAmount=2;
double zoomLevel=1;
boolean draw=true;

void setup() {
  size(1200, 1000) ;
  
  //palette.setColours(0, #0328ff, #ff0329, #9a03ff, #ff03cd, #ffab03, #fbff03, #fbff03);
  
  //palette.setColours(#010100, #DAD870, #FFCD58, #FF9636, #FF5C4D, #010100, #FDB750, #FC2E20); //lava
  
  //palette.setColours(0, #F83839, #513B41, #7FE5F0, #C8F4F9, #FD49A0, #A16AE8, #B4FEE7, #603F8B);
  
  palette.setColours(
    0,
    color(66,30,15),
    color(25, 7, 26),
    color(9, 1, 47),
    color(4, 4, 73),
    color(0, 7, 100),
    color(12, 44, 138),
    color(24, 82, 177),
    color(57, 125, 209),
    color(134, 181, 229),
    color(211, 236, 248),
    color(241, 233, 191),
    color(248, 201, 95),
    color(255, 170, 0),
    color(204, 128, 0),
    color(153, 87, 0),
    color(106, 52, 3)
  );
 
//palette.setColours(0, #FFFFFF);
 
  m=new Mandelbrot(
    palette, 
    new double[]{-2.2, 0.8}, // slightly shifted so the entire mandelbrot bulb fits on the screen
    new double[]{-1.5, 1.5}
   );
}

void draw() {
  if (draw) {
    background(0);
    loadPixels();
    translate(width/2, height/2);
    for (int x=0; x<width; x++) {
      for (int y=0; y<height; y++) {
        int index=x+y*width;
        pixels[index]=m.getPoint(x, y);
      }
    }
    updatePixels();
    draw=false;
  }
}

void zoom(double x, double y, boolean in) {
  double z=(in?1/zoomAmount:zoomAmount); //since we are reducing the bounds when zooming in and increasing when zooming out, we need to invert the zoomAmount
  zoomLevel*=z;
  
  double zoomW=(m.boundsX[1]-m.boundsX[0])*z*0.5;
  double zoomH=(m.boundsY[1]-m.boundsY[0])*z*0.5;

  m.boundsX[0]=x-zoomW;
  m.boundsX[1]=x+zoomW;
  
  m.boundsY[0]=y-zoomH;
  m.boundsY[1]=y+zoomH;
  
  println("zoom="+1/zoomLevel+"X");
  println("center=("+x + "," + y+")");
  draw=true;
}

//void mouseWheel(MouseEvent event) {
//  float e = event.getCount();
//  double x=mapDouble(mouseX, 0, width, m.boundsX[0], m.boundsX[1]);
//  double y=mapDouble(mouseY, 0, height, m.boundsY[0], m.boundsY[1]);
  
//  zoom(x, y, e<0);
//}

void mouseReleased() {

  double x=mapDouble(mouseX, 0, width, m.boundsX[0], m.boundsX[1]);
  double y=mapDouble(mouseY, 0, height, m.boundsY[0], m.boundsY[1]);
  
  zoom(x, y, mouseButton==LEFT); // zoom in with left and out with right
}

// identical to the built in `map` method, only with double precision for better zooming
 public double mapDouble(double value, double valueMin, double valueMax, double newMin, double newMax) {
    value=newMin+(newMax-newMin)*((value-valueMin)/(valueMax-valueMin));
    return value;
 }

color linInterp(color c1, color c2, float p, int i0) {
  return ceil( c1 + i0*p*(c2-c1) );  
}
