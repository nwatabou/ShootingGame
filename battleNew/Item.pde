class Item{
  float x;
  float y;
  float w = 10;
  float h = 10;
  
  boolean hit = false;  //プレイヤーに当たったかを判定するフラグ(あたり判定時に使用)
  boolean needRemove(){  //画面からはみ出るかプレイヤーに当たるとアイテム削除
    return x < 0 || x > width || y < 0 || y > height || hit;
  }
  
  Item(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void move(){
    y += 3;
  }
  
  void draw(){
    rect(x,y,10,10);
  }
}