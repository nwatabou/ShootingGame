//
//実装予定記録欄
//右上にHPの表示または残機の表示  ok
//スコアをつける ok
//アイテムの実装←さらなるあたり判定が必要に(flg+1)ダメージを受けるとflg=0にする  ok
//必殺技のようなもの
//Bossの実装
//ダメージを食らった、食らわせた感覚がほしい    ok
//
//敵、プレーヤーの姿形を変更。戦闘機っぽくできたらいいかな？    ok
//
//全方向からランダムは厳しいか？ (int型1〜4のランダム、1なら左から、2なら上からと分けるといいかも？)
//
//startボタン、ReStartボタンの実装    ok
    

ArrayList<Laser> laserList;
ArrayList<Enemy> enemyList;
ArrayList<Bullet> bulletList;
ArrayList<Item> itemList;

Player player;
//Boss boss;

PImage img;
PImage enemy;

int flg;      //アイテム入手すると+1する。弾強化処理
int n;        //撃墜数記録変数
int HP = 10;  //街の耐久力
int itemNum;  //アイテム取得数変数
int Hscore;    //ハイスコア記録変数

boolean start;  //タイトル画面処理用

  //当たり判定
boolean collision(float x1, float y1, float w1, float h1, 
                  float x2, float y2, float w2, float h2){
  if(x1 + w1/2 < x2 - w2/2) return false; //長方形1の右端
  if(x2 + w2/2 < x1 - w1/2) return false; //
  if(y1 + h1/2 < y2 - h2/2) return false; //
  if(y2 + h2/2 < y1 - h1/2) return false; //
    return true;
  }
  //それぞれのキャラと弾、2つの長方形(x,y,w,h)をもらい、この2つの長方形が「重ならない」条件を考えていく
 


void setup(){
  size(300,600);
  background(0);

  
  laserList = new ArrayList<Laser>();
  enemyList = new ArrayList<Enemy>();
  bulletList = new ArrayList<Bullet>();
  itemList = new ArrayList<Item>();
  
  
  player = new Player();
  
  flg = 0;
  start = false;
  Hscore = 0;
  
  img = loadImage("map.png");
  enemy = loadImage("enemy.png");
  
}



void draw(){
  //start画面処理、falseの時にタイトル表示
  if(!start){
    fill(0);
    rect(0, 0, width, height);
    image(img,0,0,width,height);
    
    fill(255,255,0);
    textSize(16);
    text("Push EnterKey to Start the Game !!",10,200);
    text("High score is ... " +Hscore,30, 400);
    text("click = shoot   mouse = move ",30, 500);
    if(key == ENTER){
      start = true;
    }
  }else{
    if(player.hp > 0 && HP > 0){
      fill(0);
      rect(0, 0, width, height);    //ここで動く度に背景塗り潰し
      image(img,0,0,width,height);
      
        //左上にHPの表示
      switch(player.hp){
        case 1:
          fill(255,0,0);
          text("❤", 20,20,60,60);
          break;
        case 2:
          fill(255,0,0);
          text("❤❤", 20,20,60,60);
          break;
        case 3:
          fill(255,0,0);
          text("❤❤", 20,20,60,60);
          break;
      }
      
      //街の耐久力の表示
      textSize(12);
      fill(200,200,0);
      text("↓ City's Durability",20,50);
      fill(255);
      rect(20,60,100,10,30);
      if(HP > 6){
        fill(0,0,200);
        rect(20,60,HP*10,10,30);
      }else if(HP > 3){
        fill(200,200,0);
        rect(20,60,HP*10,10,30);
      }else{
        fill(200,0,0);
        rect(20,60,HP*10,10,30);
      }
      
            //Scoreの表示
      textSize(16);
      fill(200,200,0);
      text("Score : " + player.score, 20, 80, 100, 100);
      
      
      fill(0,0,255);
      for(int i = laserList.size()-1; i >= 0; i--){
        Laser laser = laserList.get(i);
        laser.move();
        laser.draw();
      }
      
      //敵の出現処理
      //flgによって出現率を変える
      float rnd = random(160);
      if(flg == 0){
        if(rnd < 2){
          enemyList.add(new Enemy(random(10, width-10), random(1,3), random(2)));    
                    //コンストラクタに敵の出現するx座標、x・yの増加スピードをrandomで渡す
        }
      }else if(flg == 1){
        if(rnd < 3){
           enemyList.add(new Enemy(random(10, width-10), random(1,3), random(2)));   
        }
      }else if(flg == 2){
        if(rnd < 4){
          enemyList.add(new Enemy(random(10, width-10), random(1,3), random(2)));
        }
      }
      
        //スコアが1000以下の時は普通に敵出現
  //    if(player.score < 15){
        //enemyListの描画処理
        for(int j = enemyList.size()-1; j >= 0; j--){
          fill(167, 87, 168);            //敵は紫色
          Enemy enemy = enemyList.get(j);
          enemy.move();
          enemy.draw();
          
          //enemyとplayerとの当たり判定
          if(collision(player.x, player.y, 20, 20, enemy.x+15, enemy.y+15, 35, 25)){
            enemy.hit = true;
            player.hp--;
            flg = 0;
              //ダメージエフェクト
            fill(180,0,0);
            rect(0,0,width,height);
          }
          
          //enemyとlaserの当たり判定
          for(int l = laserList.size()-1; l >= 0; l--){
            Laser laser = laserList.get(l);
            if(collision(laser.x, laser.y, 3, 15, enemy.x+15, enemy.y+15, 35, 25)){
                //laserがenemyに当たったらenemyのHPを1ずつ減らす
              enemy.hp--;
                //0になったらtrueを返してRemoveする
              if(enemy.hp == 0){
                enemy.hit = true;
                player.score += 10;        //敵を倒す度にscoreを10ずつ増加
                n += 1;                    //撃墜数をカウント
                int rnd1 = int(random(1,20));
                if(rnd1 == 5){
                  enemy.itemAppear();
                }
              }
              laser.hit = true;
                  //ダメージエフェクト
                  
              //image(enemy,enemy.x,enemy.y,50,50);
              fill(255);
              rect(enemy.x+15,enemy.y+15,35,25);
              //beginShape();
              //  vertex(enemy.x,enemy.y+13);
              //  vertex(enemy.x-2,enemy.y+5);
              //  vertex(enemy.x-13,enemy.y-13);
              //  vertex(enemy.x-9,enemy.y-16);
              //  vertex(enemy.x-7,enemy.y-13);
              //  vertex(enemy.x,enemy.y-18);
              //  vertex(enemy.x+7,enemy.y-13);
              //  vertex(enemy.x+9,enemy.y-16);
              //  vertex(enemy.x+13,enemy.y-13);
              //  vertex(enemy.x+2,enemy.y+5);
              //endShape(CLOSE);
            }      
          if(laser.needRemove())laserList.remove(l);      //画面外、敵に当たったレーザーを消去
          }
            
          if(enemy.needRemove())enemyList.remove(j);    //画面外、倒された敵の消去
          if(enemy.y > 600){
            HP--;
            fill(0);
            rect(0,0,width,height);
          }
        }
  //    }else{        //1000を越えると敵の生成を止め、boss出現
        
  //      if(player.score >= 15){
  //        boss = new Boss(150,-50);
  //        fill(0,255,255);
  //        boss.move();
  //        boss.draw();
  //    }
      
      
      
      //bulletListの描画処理
      for(int k = bulletList.size()-1; k >= 0; k--){
        fill(255,255, 0);
        Bullet bullet = bulletList.get(k);
        bullet.move();
        bullet.draw();
        
              //敵の弾とプレーヤーの当たり判定
        if(collision(player.x, player.y, 20, 20, bullet.x, bullet.y, 7, 7)){
          bullet.hit = true;
          player.hp--;
          flg = 0;        //ダメージを食らったらアイテムの効果を消す
            //ダメージエフェクト
          fill(180,0,0);
          rect(0,0,width,height);
        }
        if(bullet.needRemove())bulletList.remove(k);
      }
      
      //itemListの描画処理
      for(int i = itemList.size()-1; i >= 0; i--){
        fill(0,0,170);
        Item item = itemList.get(i);
        item.move();
        item.draw();
        
        //itemListとplayerの当たり判定
        if(collision(player.x, player.y, 20, 20, item.x, item.y, 10, 10)){
          item.hit = true;
          if(flg < 2){    //当たったらflg+1してLaser強化
            flg += 1;
          }else if(flg == 2){        //flgが最大の時にアイテムを取るとボーナス点
            player.score += 300;
          }
            //アイテム獲得エフェクト
          fill(0,0,180);
          rect(0,0,width,height);
          itemNum += 1;
        }
        if(item.needRemove())itemList.remove(i);
      }
       
       //playerの描画処理
       fill(0,255,0);        //Playerは緑色
       player.move();
       player.draw();
    }else{
        //gameOver時のメッセージ処理
      fill(0);
      rect(0,0,width,height);
      
      textSize(25);
      fill(255,0,0);
      text("GAME OVER", 60, 160);
      
      textSize(16);
      fill(255,255,0);
      text("Your Score : "+player.score, 80, 200);
      text("Shoot down Score : " +n,80,230);
      
      if(player.score == 0){
        text("Are you OK ??ww",80,300);
      }else if(player.score < 100){
        text("You are bad",80,300);
      }else if(player.score < 300){
        text("So - So",80,300);
      }else if(player.score < 500){
        text("This score is average",80,300);
      }else if(player.score < 1300){
        text("You are good",80,300);
      }else if(player.score < 2000){
        text("Wonderful",80,300);
      }else{
        text("Are you genius ??",80,300);
        text("Congratulations !!",80,320);
      }
      
      if(player.hp == 3){
        text("Did you run away ?ww",80,320);
      }
      
      if(n > 150){
        text("King of Shoot Down",80,350);
      }
      
      if(itemNum > 10){
        text("You got many Items",80,400);
      }
      
      if(Hscore < player.score){
        Hscore = player.score;
      }
      textSize(14);
      text("Push BackSpaceKey to back the Title",15,500);
      if(key == BACKSPACE){
          //敵、弾、変数などの初期化
        start = false;
        player.hp = 3;
        HP = 10;
        player.score = 0;
        n = 0;
        flg = 0;
        for(int i = itemList.size()-1; i >= 0; i--){
          itemList.remove(i);
        }
        
        for(int e = enemyList.size()-1; e >= 0; e--){
          enemyList.remove(e);
        }
        
        for(int l = laserList.size()-1; l >= 0; l--){
          laserList.remove(l); 
        }
        
        for(int b = bulletList.size()-1; b >= 0; b--){
          bulletList.remove(b);
        }
      }
    }
  }
}
  
    