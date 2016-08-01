class Laser{
  float x;
  float y;
  float angle;
  float speed = 3;
  float angleSpeed = 0;
  float w;
  float h;
  int flg;
  
  boolean hit = false;  //プレイヤーに当たったかを判定するフラグ(あたり判定時に使用)
  boolean needRemove(){  //画面からはみ出るかプレイヤーに当たると弾削除
    return x < 0 || x > width || y < 0 || y > height || hit;
  }
    
  //初期値を渡せるコンストラクタ
  Laser(float x, float y, float angle, float w, float h){    
                  //プレーヤーのxy座標、発射角度、弾の幅と高さを受け取る
    this.x = x;
    this.y = y;
    this.angle = angle;
    this.w = w;
    this.h = h;

  }
  
  void move(){
    x += cos(radians(angle)) * speed;
    y += sin(radians(angle)) * speed;
  }
  
  void draw(){
    rect(x-w/2, y-h/2, w, h);
  }
}