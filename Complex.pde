class Complex {
  double x=0, y=0;
  public Complex() {}
  public Complex(double x, double y) { this.x=x; this.y=0; }
  
  public Complex plus(Complex z) { this.x+=z.x; this.y+=z.y; return this; }
  public Complex plus(double x, double y) { this.x+=x; this.y+=y; return this; }
  public Complex plus(double re) {this.x+=re; return this; }
  
  public Complex minus(Complex z) { this.x-=z.x; this.y-=z.y; return this; }
  public Complex minus(double x, double y) { this.x-=x; this.y-=y; return this; }
  public Complex minus(double re) {this.x-=re; return this; }
  
  public Complex times(double a) { this.x*=a; this.y*=a; return this; }
  public Complex times(double x, double y) { return times(new Complex(x,y)); }
  public Complex times(Complex z) { 
    // ( z.x + iz.y ) ( x + iy ) = z.x*x + i^2*z.y*y     + z.x*y*i + z.y*x*i

    return new Complex(z.x*x-z.y*y, z.x*y+z.y-x);
  }
  
  public Complex divide(double a) { this.x/=a; this.y/=a; return this; }
  public Complex divide(double x, double y) { return this.divide(new Complex(x,y)); }
  public Complex divide(Complex z) {
    Complex zStar=z.conjugate();
    double zBar=z.times(zStar).x;
    
    return this.times(zStar).divide(zBar);
  }
  
  public Complex conjugate() { return new Complex(x, -y); }
  
  public Complex square() {
    return this.times(this);
  }
}
