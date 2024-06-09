int count=0;
boolean stop=false;
boolean oneTime=false;
void setup() {
  size(800, 800);

  frameRate(120);
  colorMode(HSB);
  background(255);
  noStroke();
}
void draw() {
  blendMode(ADD);
  fill(0, 0, 255, 2);
  if (frameCount%20==0&&!stop)rect(0, 0, width, height);
  blendMode(BLEND);
  God.update();
  //text(frameRate, 100, 100);
  if (frameCount%1==0&&!stop) {
    var d = new Drop();
    var r=150+ease(noise(frameCount*0.01))*100;
    var x=width/2+cos((float)frameCount*0.02)*r;
    var y=height/2+sin((float)frameCount*0.02)*r;
    d.setPosition(x, y);
  }

  count++;
  if (stop&&God.list.size()==0)superSave();
}
void mouseClicked() {
  stop=true;
}
void superSave() {
  int num=0;
  while (loadImage(num+".png")!=null)num++;
  
  if(!oneTime){
    oneTime=true;
    save(num+".png");
  }
}
static class God {
  static ArrayList<Drop> list;
  static void birth(Drop d) {
    if (list==null)list =new ArrayList<Drop>();
    list.add(d);
  }
  static void dead(Drop d) {
    list.remove(d);
  }
  static void update() {
    if (list==null)list =new ArrayList<Drop>();
    var cp=(ArrayList<Drop>)list.clone();
    for (Drop d : cp) {
      d.update();
    }
  }
}
class Drop {
  float x=0, y=0;
  int count, max;
  color col;
  Drop() {
    col=color(ease(noise(frameCount*0.002))*115, 255, 255);
    max=120+(int)(noise(frameCount*0.002)*100);
    count=max;
    God.birth(this);
  }
  void setPosition(float _x, float _y) {
    x=_x;
    y=_y;
  }
  void update() {
    var arg=(float)count/max;
    var s=arg*30;
    fill(col);
    ellipse(x, y, s, s);
    col=color(hue(col), 255*(arg), 255*arg);
    var sp=1.5;
    var t=0.01;
    var noi=ease( noise(x*t, y*t, frameCount*0.01))*TAU;
    x+=cos(noi)*sp;
    y+=sin(noi)*sp;
    count--;
    if (count == 0) {
      fill(255, 255, 0);
      //  ellipse(x,y,10,10);
      dead();
    }
  }
  void dead() {
    God.dead(this);
  }
}
float ease(float x) {
  return x<0.5
    ?(1-sqrt(1-pow(2*x, 2)))/2
    :(sqrt(1-pow(-2*x+2, 2))+1)/2;
}
