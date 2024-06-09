int N=10;
void setup() {
  size(500, 500);
  stroke(255);
  
  strokeWeight(2);
}
void draw() {
  background(0);
  translate(width/2, height/2);
  float t=frameCount/60.0;
  rotate(cos(t)*PI/6);
  for (float i=0, n=6; i<n; i++) {
    rotate(1/n*TAU);
    chain3(N, 15, sin(t)*PI/24);
  }
}
void mouseClicked() {
  superSave();
}
void superSave() {
  int num=0;
  while (loadImage(num+".png")!=null)num++;
  save(num+".png");
}
void chain(int n, float w, float arg) {
  push();
  rotate(-PI/4);
  rec(n, w, arg);
  pop();
}
void chain2(int n, float w, float arg) {
  push();
  rotate(-PI/4);
  rec(n, w, arg);
  rec(n, w, -arg);
  pop();
}
void rec(int n, float w, float arg) {
  if (n==0)return;
  rect(0, 0, w, w);
  translate(w, w);
  rotate(arg);
  rec(n-1, w, arg);
}
void chain3(int n, float w, float arg) {
  push();
  rotate(-PI/4);
  rec2(n, w, arg);
  pop();
}

void rec2(int n, float w, float arg) {
  if (n==0)return;

  blendMode(ADD);
  noStroke();
  fill(30);
  for (float i=0, m=4; i<=m; i++) {
    var t=3.0*(float)i/m*w*(n/(float)N+0.5);
    rect(0, 0, t, t);
  }

  blendMode(BLEND);
  fill(255);
  strokeWeight(2);
  rect(0, 0, w, w);

  translate(w, w);
  rotate(arg);
  rec2(n-1, w, arg);
}
