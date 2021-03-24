class Mandelbrot {
  int MAX_ITERATIONS=1000;
  int BAILOUT_VALUE=4;
  final double LOG_2=Math.log(2);
  
  Palette pal;
  double[] boundsX={-2, 2};
  double[] boundsY={-2, 2};
  
  public Mandelbrot(Palette pal){ this.pal=pal; MAX_ITERATIONS=pal.size(); }
  public Mandelbrot(Palette pal, double[] boundsX, double[] boundsY){ 
    this.pal=pal; 
    this.boundsX=boundsX;
    this.boundsY=boundsY;
    MAX_ITERATIONS=pal.size();
  }
  
 // identical to the built in `map` method, only with double precision for better zooming
 public double mapDouble(double value, double valueMin, double valueMax, double newMin, double newMax) {
    value=newMin+(newMax-newMin)*((value-valueMin)/(valueMax-valueMin));
    return value;
 }
  
  public double log2(double arg) {
    return Math.log(arg)/LOG_2;
  }
  
  public color getPoint(int x, int y) {  
    double zx=mapDouble(x, 0, width, boundsX[0], boundsX[1]);
    double zy=mapDouble(y, 0, height, boundsY[0], boundsY[1]);
    
    double cx=zx, cy=zy; // initial conditions
    double zx2=0, zy2=0; // squares
    
    Complex c=new Complex(), zn=new Complex(), zn1=new Complex();
    
    int i=0;
    while (i<MAX_ITERATIONS) {
      zx=zx2+cx;
      zy=zy2+cy;
      
      //zn=zn1.plus(c);
      //zn1=zn.square();
      
      zx2=zx*zx-zy*zy;
      zy2=2*zx*zy;
      
       //double zz=Math.pow(zx*zx+zy*zy, 2);
       //zx2=(zx*zx-zy*zy)/zz;
       //zy2=(2*zx*zy)/zz;
       
       //zx2=Math.sin(zx)*Math.cosh(zy);
       //zy2=Math.cos(zx)*Math.sinh(zy);
       
       

       if (zx2+zy2>BAILOUT_VALUE) break;
       i++;
    }
    
    double index=0;
    
    if (i<MAX_ITERATIONS) { // point did not tend to infinity
      //double zn=Math.sqrt(zx2+zy2);
      //double u=Math.log(Math.log(zn) / LOG_2) / LOG_2;
      //index=i+1-u;
      
      double u=log2( log2(zx2+zy2)/2.0 );
      index=(Math.sqrt(i+1-u) * pal.size()) % pal.size();
    } else index=i;
    
    return pal.get(index);
  }
}
