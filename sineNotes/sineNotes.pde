import gifAnimation.*;
GifMaker gifExport;
float t;
final int FRAME_RATE=40;
void setup(){
  size(500,300);
  
  frameRate(FRAME_RATE);
  //gifExport = new GifMaker(this, "export1.gif"); // GifMakerオブジェクトを作る、第2引数にファイル名
  //gifExport.setRepeat(0); // エンドレス再生
  //gifExport.setQuality(10); // クオリティ(デフォルト10)
  //gifExport.setDelay(1000/FRAME_RATE); // アニメーションの間隔
  strokeWeight(2);
  noFill();
  
}
void draw(){
  background(255);
  translate(0,height/2);
  t=TAU*frameCount/(float)FRAME_RATE/10.0;
  for(float i=0,n=5;i<n;i++){
    float tt=t*(i+1);
    float dis=i*70;
    
    for(float j=0,m=250;j<m;j++){
      float a1=(j)*2;
      float a2=(j+1)*2;

      if((int)j%(50)==(i*10))ompu(a1,sinc((a1+dis)/m*TAU,tt)*100);
      line(a1,sinc((a1+dis)/m*TAU,tt)*100,a2,sinc((a2+dis)/m*TAU,tt)*100);  
    }
    
  }
  // if (frameCount <= FRAME_RATE*10) {
  //  gifExport.addFrame(); // フレームを追加
  //} else {
  //  gifExport.finish(); // 終了してファイル保存
  //  exit();
  //}
  
}
void cur(){
}
float sinc(float t,float a){
  float y=sin(t-a);
  return y;
}
void ompu(float x,float y){
  pushMatrix();
  translate(x,y);
  for(float i=0;i<5;i++){
    float a=-i/6.0;
    rotate(a);
    ellipse(0,0,20-i,15-i);
    rotate(-a);
  }
  line(10,0,10,-50);
  popMatrix();
}
