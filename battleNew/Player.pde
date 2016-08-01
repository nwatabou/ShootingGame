class Player{
  float x = width/2;      //初期位置は画面中央
  float y = height/2;
  
  int hp = 3;
  int score = 0;
  
  void move(){
    x = mouseX;          //Playerの移動はマウスを追いかける
    y = mouseY;
  }
  
  void draw(){
      //多角形描画処理
    beginShape();
      vertex(x,y-13);
      vertex(x-2,y-5);
      vertex(x-13,y+13);
      vertex(x-9,y+16);
      vertex(x-7,y+13);
      vertex(x,y+18);
      vertex(x+7,y+13);
      vertex(x+9,y+16);
      vertex(x+13,y+13);
      vertex(x+2,y-5);
    endShape(CLOSE);
    
    if(mousePressed){
      if(frameCount % 20 == 0){                    //マウスを押してる間0.5秒間隔でレーザー発射
        laserShot();
      }
    }
  }
  
  //Playerの攻撃処理
  //アイテムを取ったらflg+1、最大3本までレーザー増える
  void laserShot(){
    switch(flg){
      case 0:
        laserList.add(new Laser(x, y, -90, 3, 20));    //正面1本
        break;
      
      case 1:
        laserList.add(new Laser(x, y, -75, 3, 20));    //正面30°に2本
        laserList.add(new Laser(x, y, -105, 3, 20));
        break;
        
      case 2:
        laserList.add(new Laser(x, y, -90, 3, 20));    //正面15°ずつ3本
        laserList.add(new Laser(x, y, -75, 3, 20));
        laserList.add(new Laser(x, y, -105, 3, 20));
        break;
    }
  }
}