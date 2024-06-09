import gifAnimation.*;
// GifMakerクラスを呼ぶ
GifMaker gifExport;
final int FRAME_RATE=50;
void setup() {
  size(600, 600);
  translate(width/2, height/2);
  
  frameRate(FRAME_RATE);
  //gifExport = new GifMaker(this, "export1.gif"); // GifMakerオブジェクトを作る、第2引数にファイル名
  //gifExport.setRepeat(0); // エンドレス再生
  //gifExport.setQuality(10); // クオリティ(デフォルト10)
  //gifExport.setDelay(1000/FRAME_RATE); // アニメーションの間隔
  noStroke();
}
void draw() {
  
  float a=frameCount/(float)FRAME_RATE*0.5;
  float s=150;
  //background(128);
  //background(map(sin(PI/2+(a*TAU)),-1,1,0,1)*255);
  for (float i=0, n=width/s; i<=n; i++) {
    for (float j=0, m=n; j<=m; j++) {
      boolean b=(i+j)%2==0;
      //fill(b?255:0);
      //rect(i*s,j*s,s,s);
      fill(b?0:255);
      //rec(i*s,j*s,s,((((b?1:0.5)+a)%1.0)));
      float d=dist(i/n,j/n,0.5,0.5);
      d=0;
      rec(i*s,j*s,s,(a+d)%1.0);
      fill(!b?0:255);
      rec(i*s,j*s,s,(0.5+a+d)%1.0);
    }
  }
  //if (FRAME_RATE<=frameCount&&frameCount <= FRAME_RATE*3) {
  //   gifExport.addFrame(); // フレームを追加
  //}else if(frameCount<FRAME_RATE){} 
  //else {
  //  gifExport.finish(); // 終了してファイル保存
  //  exit();
  //}
  
}
void rec(float x, float y, float w, float t) {
  w+=2;
  beginShape();
  vertex(x+w*t, y);
  vertex(x+w, y+w*t);
  vertex(x+w*(1-t), y+w);
  vertex(x, y+w*(1-t));
  endShape(CLOSE);
}
