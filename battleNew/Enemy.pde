class Enemy{
  float x;
  float y;
  float xSpeed;
  float ySpeed;
  int i;
  
  int hp = 3;
  
  
  
  boolean hit = false;
  boolean needRemove(){
    return x < 0 || x > width || y < 0 || y > height || hit;
  }
  
  
  Enemy(float Ex, float xSpeed, float ySpeed){    //random生成された出現x座標、x・yの増加スピード受け取ってる
    x = Ex;
    y = 0;
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
  }
  
  void move(){
    x += xSpeed;            //xをxspeedずつ増加させる
    y += ySpeed;            //yをySpeedずつ増加させる
    if(x+10 > width){
      xSpeed *= -1;        //敵の半分が画面から出たら-1をかけて跳ね返らせる
    }else if(x-10 < 0){
      xSpeed *= -1;        
    }
  }
  
  void draw(){
    
    image(enemy,x,y,50,50);
    //beginShape();
    //  vertex(x,y+13);
    //  vertex(x-2,y+5);
    //  vertex(x-13,y-13);
    //  vertex(x-9,y-16);
    //  vertex(x-7,y-13);
    //  vertex(x,y-18);
    //  vertex(x+7,y-13);
    //  vertex(x+9,y-16);
    //  vertex(x+13,y-13);
    //  vertex(x+2,y+5);
    //endShape(CLOSE);
    float rnd = random(200);
      //Laserが強化されるにつれてbullet増加
    if(flg == 0){
      if(rnd < 1){
        bulletShot();
      }
    }else if(flg == 1){
      if(rnd < 2){
        bulletShot();
      }
    }else if(flg == 2){
      if(rnd < 4){
        bulletShot();
      }
    }
  }
  
  void bulletShot(){
       //敵の弾の速さは4〜7のランダム
   i = int(random(4,8));
       //敵のxy座標、弾のスピードをコンストラクタに渡す
   bulletList.add(new Bullet(x, y,i));
  }
  
  void itemAppear(){
   itemList.add(new Item(x,y)); 
  }
}