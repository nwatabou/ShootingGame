class Bullet{
  float x;
  float y;
  float speed;
  
  boolean hit = false;
  boolean needRemove(){  //画面からはみ出るかプレイヤーに当たると弾削除
    return x < 0 || x > width || y < 0 || y > height || hit;
  }
  
  Bullet(float x, float y, float speed){    //敵のxy座標を受け取るコンストラクタ
    this.x = x;
    this.y = y;
    this.speed = speed;
  }
  
  void move(){
    y += speed;        //弾のスピード、5ずつ増加
  }
  
  void draw(){
   ellipse(x, y, 7, 7); 
  }
}