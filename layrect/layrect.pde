final float REC=150; //<>//
final PVector P[]=
  {new PVector(-REC, -REC), 
  new PVector(REC, -REC), 
  new PVector(REC, REC), 
  new PVector(-REC, REC)};
float ww, hh;
void setup() {
  size(500, 500);
  rectMode(CENTER);
  blendMode(ADD);

  ww=width/2;
  hh=height/2;
  // noLoop();
  smooth();
  noLoop();
}
void draw() {
  background(0);
  stroke(0);
  translate(ww, hh);
  //rect(0, 0, REC*2, REC*2);
  //for (int i=0; i<20; i++)lay(1.0, 328-i*50);
  for (int i=0; i<20; i++)lay(1.0, 458.9-i*50);
}
void l(float a, float phase) {
  PVector p1=new PVector(-ww, -hh*a+phase);
  PVector p2=new PVector(ww, hh*a+phase);
  stroke(255);
  line(p1.x, p1.y, p2.x, p2.y);
}
  
void lay(float a, float phase) {
  PVector p1=new PVector(ww, hh*a+phase);
  PVector p2=new PVector(-ww, -hh*a+phase); //<>//
 //<>// //<>//
  //line(p1.x, p1.y, p2.x, p2.y); //<>// //<>//
  
  //line(p1.x, p1.y, p2.x, p2.y); //<>// //<>// //<>//
  stroke(0);
  ArrayList<PVector> cp=culPoints(a, phase); //<>//
  for (PVector p : cp) {
    //  circle(p.x, p.y, 10);
  }
  stroke(255);
  if (cp.size()>1) {
    //drawSign(cp.get(0), cp.get(1));
    strokeWeight(3);
    stroke(255,0,0);
    drawSign(cp.get(0), cp.get(1),15);
    stroke(0,255,0);
    drawSign(cp.get(0), cp.get(1),25);
    stroke(0,0,255);
    drawSign(cp.get(0), cp.get(1),35);
    stroke(255);
    line(p1.x, p1.y, cp.get(1).x, cp.get(1).y);
    line(cp.get(0).x, cp.get(0).y, p2.x, p2.y);
  } else {
    stroke(255);
    strokeWeight(3);
    line(p1.x, p1.y, p2.x, p2.y);
  }
}
void mouseClicked(){
  int i;
  for (i=0; loadImage(i+".png")!=null; i++);
  save(i+".png");
}
ArrayList<PVector> culPoints(float a, float phase) {
  PVector p1=new PVector(ww, hh*a+phase);
  PVector p2=new PVector(-ww, -hh*a+phase);
  ArrayList<PVector>r=new ArrayList<PVector>();
  PVector tp[]=new PVector[4];

  tp[0]=intersection(p1, p2, P[0], P[1]);
  tp[1]=intersection(p1, p2, P[0], P[3]);  
  tp[2]=intersection(p1, p2, P[1], P[2]);
  tp[3]=intersection(p1, p2, P[2], P[3]);  
  for (int i=0; i<tp.length; i++) {
    if ((-REC<=tp[i].x&&tp[i].x<=REC)&&(-REC<=tp[i].y&&tp[i].y<=REC)) {
      r.add(tp[i].copy());
    }
  }
  return r;
}

PVector intersection(PVector p1, PVector p2, PVector p3, PVector p4) {
  float det=(p1.x - p2.x) * (p4.y - p3.y) - (p4.x - p3.x) * (p1.y - p2.y);
  float t = ((p4.y - p3.y) * (p4.x - p2.x) + (p3.x - p4.x) * (p4.y - p2.y)) / det;
  float x = t * p1.x + (1.0 - t) * p2.x;
  float y = t * p1.y + (1.0 - t) * p2.y;
  return new PVector(x, y);
}
class Lay {
  float dir;
  float phase;
}
void drawSign(PVector p1, PVector p2) {
  strokeWeight(3);
  stroke(255);
  float h=10;
  //line(p1.x,p1.y,p2.x,p2.y);
  for (float i=0, n=1000; i<n; i++) {
    PVector p=PVector.lerp(p1, p2, i/n);
    p.y+=sin(i/n*PI*((int)dist(p1.x, p1.y, p2.x, p2.y)/17))*h;
    point(p.x, p.y);
  }
}
void drawSign(PVector p1, PVector p2,int s) {
  strokeWeight(3);
  
  float h=10;
  //line(p1.x,p1.y,p2.x,p2.y);
  for (float i=0, n=1000; i<n; i++) {
    PVector p=PVector.lerp(p1, p2, i/n);
    p.y+=sin(i/n*PI*((int)dist(p1.x, p1.y, p2.x, p2.y)/s))*h;
    point(p.x, p.y);
  }
}
