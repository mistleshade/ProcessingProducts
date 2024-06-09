import gifAnimation.*;
// GifMakerクラスを呼ぶ
GifMaker gifExport;
void setup() {
  size(512, 512);
  //  noLoop();
  strokeWeight(10);
  //blendMode(ADD);
  final int FRAME_RATE=50;
  frameRate(FRAME_RATE);
  //gifExport = new GifMaker(this, "export1.gif"); // GifMakerオブジェクトを作る、第2引数にファイル名
  //gifExport.setRepeat(0); // エンドレス再生
  //gifExport.setQuality(10); // クオリティ(デフォルト10)
  //gifExport.setDelay(1000/FRAME_RATE); // アニメーションの間隔
}
void draw() {
  background(0);
  translate(width/2, height/2);


  for (float j=0, m=5; j<m; j++) {
    for (float i=0, n=20; i<n; i++) {
      
      var t = map(sin((frameCount+(i)*10)/n/10*TAU+(j/m)*TAU), -1, 1, 1, n/2);
      stroke(255*j/m);
      var r = 30+j*40;
      var x1 = cos(i/n*TAU)*r;
      var y1 = sin(i/n*TAU)*r;
      var x2 = cos((i+1)/n*TAU)*r;
      var y2 = sin((i+1)/n*TAU)*r;
      var sc = map(j/m,0,1,1,1.2);
      pointArc(x1, y1, x2, y2, PI/(t)*sc);
    }
  }

  //if (frameCount <= 200) {
  //   gifExport.addFrame(); // フレームを追加
  //} else {
  //  gifExport.finish(); // 終了してファイル保存
  //  exit();
  //}
}
void pointArc(float A, float B, float C, float D, float angle) {

  var x = (int)(A + (B -D)/tan(angle/2) + C)/2;
  var y = (int)((C - A)/tan(angle/2)+ B + D)/2;
  
  noFill();
  var a1 = (atan2(y-B, x-A))%TAU+PI;
  var a2 =a1 + angle;
  var r = (int)dist(x, y, A, B)*2;
  arc(x, y, r, r, a1, a2);
}
