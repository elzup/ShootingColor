
class Player {
  int maxLife;

  float x, y;
  float v;
  float r;
  boolean isDead;
  int life;
  int remains;
  float lifeRate;
  int shotTimer;
  int dieTimer;
  int rebornTimer;
  int score;
  boolean continueFlag;
  
  color cl;
  Weapon[] weapon=new Weapon[3];

  boolean[] isClear=new boolean[5];

  float getX() {
    return x;
  }
  float getY() {
    return y;
  }
  float getR() {
    return r;
  }
  float getV() {
    return v;
  }
  boolean isDead() {
    return isDead;
  }
  boolean isClear(int n) {
    return isClear(n);
  }

  void setWeapon(int n, Weapon w) {
    weapon[n]=w;
    weapon[n].setting(n);
  }

  boolean checkW(int k) {
    for (int i=0;i<3;i++) {
      if (weapon[i].ID==k)return false;
    }
    return true;
  }

  Player() {
    for (int i=0;i<3;i++) {
      weapon[i]=new Weapon();
    }
  }
  Player(float x, float y, float r, int life, color cl) {
    this.x=x;
    this.y=y;
    this.r=r;
    this.life=maxLife=life;
    this.cl=cl;
    for (int i=0;i<5;i++)isClear[i]=false;
    remains=PlayerRemains;
    v=PlayerSpeed;
    rebornTimer=100;
    for (int i=0;i<3;i++) {
      weapon[i]=new Weapon();
    }
    score=0;
    continueFlag=false;
  }

  void update() {
    //    x=mouseX;
    //    y=mouseY;
    //    if(keyPressed && key==CODED){
    float sp=v;
    //      if(keyCode==SHIFT)sp/=2;
    //      if(keyCode==UP)y-=v;
    //      else if(keyCode==DOWN)y+=v;
    //      if(keyCode==RIGHT)x+=v;
    //      else if(keyCode==LEFT)x-=v;
    if (rebornTimer>0) {
      y--;
      rebornTimer--;
      return;
    }
    if (buf[SHIFT%256])sp/=2;
    if (buf[UP%256])y-=sp;
    else if (buf[DOWN%256])y+=sp;
    if (buf[RIGHT%256])x+=sp;
    else if (buf[LEFT%256])x-=sp;
    
    if(buf[CONTROL%256]){
      
    }

    if (x<0)x=0;
    if (x>width)x=width;
    if (y<0)y=0;
    if (y>height)y=height;

    //    for (int i=0;i<3;i++) {
    //      if (weapon[i].isSet)weapon[i].update();
    ////      println(weapon[i].isSet);
    //    }
    if (weapon[0].isSet)weapon[0].update(buf['a'%256], x, y);
    if (weapon[1].isSet)weapon[1].update(buf['s'%256], x, y);
    if (weapon[2].isSet)weapon[2].update(buf['d'%256], x, y);

    //    }
    if (dieTimer>0)dieTimer--;
    
    if(gameMode==PROCESS_GAME){
      updateScore();
    }
  }
  
  void updateScore(){
    
    score=(int)((1-enemy.lifeRate)*StageScoreMax/2);
    
    fill(clo[cloWhite]);
    textSize(20);
    text(score,width-100,height-20);
  }
  
  int resultScore(){
    
    float lifeRate=(remains*(PlayerLife)+life)/(PlayerLife*PlayerRemains);
    int lifeScore=(int)lifeRate*StageScoreMax/2;
    if(continueFlag)lifeScore=0;
    return score+lifeScore;
  }
  
  void move(float dx, float dy) {
    this.x+=dx*v;
    this.y+=dy*v;
  }


  void fire() {
    if (((mousePressed) || buf[' '%256]) && shotTimer==0) {  
      setBullet(x, y, 0, -10, 10, cl, 20);
      shotTimer=20;
    }
    //    if (buf['a'%256] && weapon[0].isSet);
    //    if (buf['s'%256] && weapon[1].isSet)weapon[1].fire(x, y);
    //    if (buf['d'%256] && weapon[2].isSet)weapon[2].fire(x, y);
    //    if (!mousePressed) {
    //      shotTimer=0;
    //    }
    if (shotTimer>0)shotTimer--;
  }



  void setBullet(float x, float y, float vx, float vy, float r, color cl, int f) {
    for (int i=0;i<playerBullet.length;i++) {
      if (playerBullet[i].isDead()) {
        playerBullet[i].setBullet(x, y, vx, vy, r, cl, f);
        //        print(" <"+"["+i+"]"+(int)vx+","+(int)vy+">");
        break;
      }
    }
  }
  


  void reduceLife(int damage) {
    if (dieTimer>0)return;
    life-=damage;
    //    print(damage);
    if (life<=0) {
      life=0;
      kill();
    }
    dieTimer=20;
  }
  void cureLife(int cure){
    life+=cure;
    if(life>PlayerLife)life=PlayerLife;
  }
  
  void kill() {
    remains--;
    setSpark(x, y, 50, 200, clo[cloWhite]);
    if (remains==0) {
      isDead=true;
      gameMode=PROCESS_OVER;
      return;
    }
    else revivereturn();
  }

  void revivereturn() {
    life=PlayerLife;
    x=width/2;
    y=height;
    rebornTimer=100;
    dieTimer=100;
  }

  void reborn() {
    remains=PlayerRemains;
    revivereturn();
    continueFlag=true;
  }


  void draw() {
    fill(cl);
    if (dieTimer%2==1 || rebornTimer%2==1) {
      fill(clo[cloBlack]);
    }
    ellipse(x, y, r*2, r*2);

    drawLifeBar();
  }

  void drawLifeBar() {

    int X_R=15;
    int Y_R=width-35;
    int YD_R=12;    
    for (int r=0;r<remains-1;r++) {
      fill(clo[cloWhite]);
      ellipse(X_R, Y_R+YD_R*r, 10, 10);
    }

    lifeRate=life/(float)maxLife;
    fill(0, 0, 20);
    rect(10, height-10, 100, 10);
    fill(0, 0, 100);
    rect(10, height-10, lifeRate*(100), 10);
    //    print(life+"\n");
  }
}


class DemoPlayer extends Player {
  DemoPlayer(float x, float y, float r, boolean die, color cl) {
    super(x, y, r, 10000, cl);
    isDead=die;
  }
  void update() {
    float sp=v;
    if (buf[SHIFT%256])sp/=2;
    if (buf[UP%256])y-=sp;
    else if (buf[DOWN%256])y+=sp;
    if (buf[RIGHT%256])x+=sp;
    else if (buf[LEFT%256])x-=sp;



    if (x<DEMO_X+10)x=DEMO_X+10;
    if (x>DEMO_X+DEMO_W-10)x=DEMO_X+DEMO_W-10;
    if (y<DEMO_Y+10)y=DEMO_Y+10;
    if (y>DEMO_Y+DEMO_H-10)y=DEMO_Y+DEMO_H-10;
    if (weapon[0].isSet)weapon[0].update(buf['a'%256], x, y);
    if (weapon[1].isSet)weapon[1].update(buf['s'%256], x, y);
    if (weapon[2].isSet)weapon[2].update(buf['d'%256], x, y);
  }

  void draw() {
    fill(clo[cloWhite]);
    rect(DEMO_X, DEMO_Y, DEMO_W, DEMO_H);
    fill(clo[cloBlack]);
    rect(DEMO_X+5, DEMO_Y+5, DEMO_W-10, DEMO_H-10);
    fill(cl);
    ellipse(x, y, r*2, r*2);

    drawLifeBar();
  }
}

