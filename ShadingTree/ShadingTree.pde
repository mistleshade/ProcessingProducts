ArrayList<Particle> pl;
ArrayList<Drop> dl;

ArrayList<Circle> cl;
void setup() {
  size(1980,1080, P2D);
  colorMode(HSB);
  blendMode(ADD);
  pl=new ArrayList<Particle>();
  dl=new ArrayList<Drop>();
  cl=new ArrayList<Circle>();
  frameRate(180);
  background(0);
  int s=30;
  strokeWeight(2);
  for (int i=0; i<width; i++) {
    if (i%s!=0)continue;
    for (int j=0; j<height; j++) {
      if (j%s!=0)continue;
      pl.add(new Particle(i, j));
    }
  }
}
void draw() {
  blendMode(ADD);
  for (int i=0; i<pl.size(); i++)pl.get(i).move();
  if (frameCount%60==0)println(frameRate);
  blendMode(BLEND);
  for (int i=0; i<dl.size(); i++)dl.get(i).move();
  for (int i=0; i<cl.size(); i++)cl.get(i).move();
  searchWhite();
  //println(step(mouseX,100));
}
void keyPressed() {
  saveFrame("sa-####.png");
  background(0);
  rand=random(0, 10000);
  for (int i=0; i<pl.size(); i++)pl.get(i).gnoise+=100;
  cl.clear();
  int n=(int)random(1,4);
  for (int i=0; i<n; i++) {
    cl.add(new Circle(random(width), random(height), random(500, 700)));
  }
}
class Circle {
  Circle(float _x, float  _y, float _r) {
    x=_x;
    y=_y;
    radius=_r;
  }
  float x, y;
  float radius;
  boolean isInside(float _x, float _y) {
    return dist(x, y, _x, _y)<=radius/2;
  }
  void move() {
    noFill();
    stroke(255,50);
    //ellipse(x, y, radius, radius);
  }
}
void searchWhite() {
  float x=frameCount*10%width, y=((frameCount*10-x))%height;

  color col=get((int)x, (int)y);
  float g=green(col);
  float b=blue(col);
  float r=red(col);
  if (r+g+b>=253*3) {
    println("WHITE!");
    // dl.add(new Drop(x,y));
  }
}
class Drop {

  PImage sp;
  float x, y;
  float sx, sy;
  float acc;
  float count;
  Drop( float _x, float _y) {
    x=_x;
    y=_y;
    sy=0;
  }
  void move() {
    fill(255, 0, 255, 128);
    float s=log(count);
    ellipse(x, y, s, s);
    y+=sy;
    sy+=0.01;
    count++;
    if (y>height+50)dl.remove(this);
  }
}
float rand=0;
class Particle {
  float x, y;
  float sx, sy;
  color col;
  float xnoise, ynoise, cnoise;
  float gnoise;
  int life;
  float s;
  Particle(float _x, float _y) {
    x=_x;
    y=_y;
    life=(int)(random(1.0, 1.5)*60);
    xnoise=(x-width/2)*.005;
    ynoise=(y-height/2)*.005;
    s=128;
    col=color(map(noise(xnoise, ynoise, rand), 0, 1, -s, 255+s)%255, 255, 255, 50);
    gnoise=0;
  }
  void move() {
    float ns=.01;
    //col=color(128, 255, 255, 5);


    x+=sx;
    y+=sy;
    xnoise=(x-width/2)*ns;
    ynoise=(y-height/2)*ns;
    float ss=PI*2;
    //ss+=map(distCenter(x,y),0,width,0,PI);
    float rt=1;
    float dir;
    //dir=map(noise(xnoise, ynoise, gnoise+rand), 0, 1, -ss, ss);
    int sc=15;
    float stp=(((step(x, sc)+step(y, sc))/sc)%2)*10;
    boolean in=false;
    // dir=map(noise(xnoise, ynoise, stp+rand), 0, 1, -ss, ss);

    for (Circle c : cl) {
      if (c.isInside(x, y)) {
        //println("IN!");

        in=true;
        break;
      }
    }
    if (!in){
       col=color(map(noise(xnoise, ynoise, rand), 0, 1, -s, 255+s)%255, 255, 255, 20);
      dir=map(noise(xnoise, ynoise, step(x,10)+rand), 0, 1, -ss, ss);
    }
    else {
       col=color(map(noise(xnoise, ynoise), 0, 1, -s, 255+s)%255, 128, 255, 50);
      dir=map(noise(xnoise, ynoise), 0, 1, -ss, ss);
    }
    stroke(col);
    point(x, y);
    sx=cos(dir)*rt;
    sy=sin(dir)*rt;
    life--;
    if (!isInsketch()||life<=0) {
      x=random(width);
      y=random(height);
      // col=color(random(255), 255, 255, 5);
      //gnoise+=0.01f;
      //col=color((128+gnoise*600)%255, 255, 255, 30);
      xnoise=(x-width/2)*.01;
      ynoise=(y-height/2)*.01;

      col=color(map(noise(xnoise, ynoise, rand), 0, 1, -s, 255+s)%255, 255, 255, 50);
      life=(int)(random(1.0, 5.0)*60);
    }
  }
  boolean isInsketch() {
    if (x<0||width<x) {
      return false;
    }
    if (y<0||height<y) {
      return false;
    }
    return true;
  }
}
float distCenter(float x, float y) {
  float cx=width/2, cy=height/2;

  return dist(x, y, cx, cy);
}
float step(float t, int n) {
  int j=(int)(t/n);
  return j*n;
}
