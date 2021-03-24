class Palette {
  int stepSize;
  int n=0;
  ArrayList<Integer> palette=new ArrayList<Integer>();
  
  public Palette(int stepSize){ this.stepSize=stepSize; }
  
  public int size() { return palette.size(); }
  
  private void createGradient(color c1, color c2) {
    if (stepSize==0) return;
    int range0=n+1;
    int range1=n+stepSize;
    
    float r1=red(c1); float g1=green(c1); float b1=blue(c1);
    float r2=red(c2); float g2=green(c2); float b2=blue(c2);
    
    float dr=(r2-r1)/(range1-range0);
    float dg=(g2-g1)/(range1-range0);
    float db=(b2-b1)/(range1-range0);
    
    for (int i=range0; i<range1; i++) {
      palette.add(
        color(
          r1+ceil(dr*i),
          g1+ceil(dg*i),
          b1+ceil(db*i)
        )
      );
    }
  }
  
  public void setColours(color... colours) {
    if (colours!=null && colours.length>0) {
      color prev=-1;
      for (color c: colours) {
        if (prev!=-1) {
          addColour(prev, c);
        }
        prev=c;
      }
    }
  }
  
  public Palette addColour(color c1, color c2) {
    this.createGradient(c1, c2);
    return this;
  }
  
  //public color get(int index) {
  //  index=(int) Math.floor(mod(index, palette.size()));
    
  //  if (index<0) index+=palette.size();
  //  return palette.get(index);
  //}
  
  private color colourBetween(color c1, color c2, double p) {
    // get the colour some percentage p between c1 and c2
    double r1=red(c1); double g1=green(c1); double b1=blue(c1);
    double r2=red(c2); double g2=green(c2); double b2=blue(c2);
    
    double rp=(Math.abs(r2-r1))*p+r1;
    double gp=(Math.abs(g2-g1))*p+g1;
    double bp=(Math.abs(b2-b1))*p+b1;
    
    return color((float) rp, (float) gp, (float) bp);
  }
  
  public color get(double index) {
    // ensure the index is in the palette range
    double fractionalIndex=mod(index, palette.size());
    
    int index0=(int) Math.floor(fractionalIndex);
    int index1=(int) Math.ceil(fractionalIndex);
    if (index1>=palette.size()) index1=0;
    
    return colourBetween(palette.get(index0), palette.get(index1), frac(fractionalIndex));
  }
  
  double frac(double num) {
    return num-Math.floor(num);
  }
  
  double mod(double num, double radix) {
    double count=Math.floor(num/radix);
    return num-count*radix;
  }
}
