class Enemy {
  int maxLife;

  float x, y;
  float r;
  boolean isDead;
  int state;
  int life;
  float lifeRate;
  float theta;
  float dtheta;
  int shotTimer;
  int shotTimerLev;
  float vshot;
  int actTimer;
  int actPat;
  int gard;
  float speed;

  float shotR;
  int rd;
  float dx,dy;
  
  boolean cureFlag=false;

  color cl;

  float getX() {
    return x;
  }
  float getY() {
    return y;
  }
  float getR() {
    return r;
  }
  boolean isDead() {
    return isDead;
  }

  Enemy(float x, float y, float r, int life, color cl) {
    this.x=x;
    this.y=y;
    this.r=r;
    this.life=maxLife=life;
    theta=90;
    dtheta=0;
    shotTimerLev=100;
    vshot=10;
    this.cl=cl;
    actPat=100;
    actTimer=150;
    state=1;
    gard=0;
    deadTimer=0;

    speed=1;
  }

  void update() {
    act();
    if (deadTimer>0) {
      if ((int)random(3)==1 && deadTimer%5==0) {
        float rr=random(50);
        float rx=random(width);
        float ry=random(height/2);
        setSpark(rx, ry, (int)rr, 100, cl);
        rr=random(50, 100);
        rx=random(width);
        ry=random(height/2);
        setSpark(rx, ry, (int)rr, 100, clo[cloWhite]);
      }
      deadTimer--;
      if (deadTimer==0) {
        gameMode=PROCESS_CLEAR;
      }
    }
  }

  void act() {
  }

  void fire() {
  }

  void setBullet(float x, float y, float vx, float vy, float r, color cl, int f) {

    for (int i=0;i<enemyBullet.length;i++) {
      if (enemyBullet[i].isDead()) {
        enemyBullet[i].setBullet(x, y, vx, vy, r, cl, f);
        break;
      }
    }
  }
  void setBullet(float x, float y, float vx, float vy, float r, color cl, int f,int type) {

    for (int i=0;i<enemyBullet.length;i++) {
      if (enemyBullet[i].isDead()) {
        enemyBullet[i].setBullet(x, y, vx, vy, r, cl, f,type);
        break;
      }
    }
  }
  void setBullet(float x, float y, float vx, float vy, float r, color cl, int f, int type, int bNum, float sp, int time) {        //type 1=flower
    for (int i=0;i<enemyBullet.length;i++) {
      if (enemyBullet[i].isDead()) {
        enemyBullet[i].setBullet(x, y, vx, vy, r, cl, f, type, bNum, sp, time);
        //        print (f);
        break;
      }
    }
  }


  int deadTimer;
  void reduceLife(int power) {
    int damage=power-gard;
    if (damage>0)life-=damage;
    else life--;
    if (life<=0) {
      life=0;
      isDead=true;
      deadTimer=200;
      actPat=100;
      actTimer=200;
      return;
    }
    shotTimerLev-=lifeRate;
    if (lifeRate<0.5 && state==1) {
      state=2;
      gard=10;
    }
  }

  void cureLife(int cure){
    life+=cure;
    if(life>maxLife)life=maxLife;
  }


  void draw() {
    fill(cl);
    if (deadTimer%2==1)fill(clo[cloWhite]);
    if(cureFlag){
      fill(clo[cloWhite]);
    }
    ellipse(x, y, r*2, r*2);
    drawLifeBar();
  }

  void drawLifeBar() {
    lifeRate=life/(float)maxLife;
    fill(0, 0, 30);
    rect(10, 10, width-20, 10);
    fill(cl);
    rect(10, 10, lifeRate*(width-20), 10);
  }

  void setRd(int a, int b) {
    rd=(int)random(a, b);
  }
  void setRd(boolean a) {
    rd=90-(int)getDeg()%360;
    if(rd%180==0)rd+=180;
    if(dy>0 && rd>0 && rd<180){
      rd+=180;
    }
    
  }

  float getDeg() {
    dx=player.getX()-x;
    float dy=player.getY()-y;
    //    float dtheta=atan(dy/dx);
    //    float rad=radians(dtheta);
    float rad=atan(dy/dx);
    float deg=degrees(rad);
    if (dx>0)return deg;
    return deg+180;
  }

  ////////////////////////////////////////////////////////////////////////////////////
  void fire(int num, int dt) {
    //      println((int)(lifeRate*10));
    for (int i=1;i<num+1;i++) {
      float rad;
      if (num%2==1) {
        rad=radians(15*(i/2*((i%2)*2-1))+dt);
      }
      else {
        rad=radians(7.5+15*(i/2*((i%2)*2-1))+dt);
      }
      float vx=vshot*sin(rad)/2;
      float vy=vshot*cos(rad)/2;
      setBullet(x, y, vx, vy, shotR, cl, 10);
    }
  }

  void fire(int num, int dt, float sp) {
    //      println((int)(lifeRate*10));
    for (int i=1;i<num+1;i++) {
      float rad;
      if (num%2==1) {
        rad=radians(15*(i/2*((i%2)*2-1))+dt);
      }
      else {
        rad=radians(7.5+15*(i/2*((i%2)*2-1))+dt);
      }
      float vx=sp*sin(rad)/2;
      float vy=sp*cos(rad)/2;
      setBullet(x, y, vx, vy, shotR, cl, 10);
    }
  }
  void fire(int num, int dt, float sp, float direx, float direy) {
    //      println((int)(lifeRate*10));
    for (int i=1;i<num+1;i++) {
      float rad;
      if (num%2==1) {
        rad=radians(15*(i/2*((i%2)*2-1))+dt);
      }
      else {
        rad=radians(7.5+15*(i/2*((i%2)*2-1))+dt);
      }
      float vx=sp*sin(rad)/2;
      float vy=sp*cos(rad)/2;
      setBullet(x+direx, y+direy, vx, vy, shotR, cl, 10);
    }
  }
  void fire(int num, int dt, float sp, float direx, float direy ,int type) {
    //      println((int)(lifeRate*10));
    for (int i=1;i<num+1;i++) {
      float rad;
      if (num%2==1) {
        rad=radians(15*(i/2*((i%2)*2-1))+dt);
      }
      else {
        rad=radians(7.5+15*(i/2*((i%2)*2-1))+dt);
      }
      float vx=sp*sin(rad)/2;
      float vy=sp*cos(rad)/2;
      setBullet(x+direx, y+direy, vx, vy, shotR, cl, 10,type);
    }
  }

  void fire(int num, int dt, float sp, float direx, float direy, float r, int f) {
    //      println((int)(lifeRate*10));
    for (int i=1;i<num+1;i++) {
      float rad;
      if (num%2==1) {
        rad=radians(15*(i/2*((i%2)*2-1))+dt);
      }
      else {
        rad=radians(7.5+15*(i/2*((i%2)*2-1))+dt);
      }
      float vx=sp*sin(rad)/2;
      float vy=sp*cos(rad)/2;
      setBullet(x+direx, y+direy, vx, vy, r, cl, f);
    }
  }



  void fireShot(float vs) {
    float deg=getDeg();
    //    rd=(int)deg;
    float rad=radians(deg);
    float vx, vy;
    vx=vs*cos(rad);
    vy=vs*sin(rad);
    if (dx==0) {
      vx=0;
      vy=vs;
    }
    //    println(dtheta);
    setBullet(x, y, vx, vy, shotR, cl, 10);
  }
  void fireShot(float vs,int type) {
    float deg=getDeg();
    //    rd=(int)deg;
    float rad=radians(deg);
    float vx, vy;
    vx=vs*cos(rad);
    vy=vs*sin(rad);
    if (dx==0) {
      vx=0;
      vy=vs;
    }
    //    println(dtheta);
    setBullet(x, y, vx, vy, shotR, cl, 10,type);
  }
  
  void fireShot(float vs, float dt) {
    float deg=getDeg();
    //    rd=(int)deg;
    float rad=radians(deg+dt);
    float vx, vy;
    vx=vs*cos(rad);
    vy=vs*sin(rad);
    if (dx==0) {
      vx=0;
      vy=vs;
    }
    //    println(dtheta);
    setBullet(x, y, vx, vy, shotR, cl, 10);
  }
  void fireShot(float vs, float dt, float ddx, float ddy, float r, int f) {
    float deg=getDeg();
    //    rd=(int)deg;
    float rad=radians(deg+dt);
    float vx, vy;
    vx=vs*cos(rad);
    vy=vs*sin(rad);
    if (dx==0) {
      vx=0;
      vy=vs;
    }
    //    println(dtheta);
    setBullet(x+ddx, y+ddy, vx, vy, r, cl, f);
  }

  void fireLine(float n, float sp, float dx, float r, int f) {
    for (int i=0;i<n;i++) {
      float xx=x+dx*(i-(n/2));
      setBullet(xx, y, 0, sp, r, cl, f);
    }
  }
  void fireLine(float n, float sp, float dx, float r, int f, boolean ccc) {
    float cenD=n/2+((n+1)%2)*0.5;
    if (ccc) {
      for (int i=0;i<n;i++) {
        float xx=x+dx*(i-(n/2));
        setBullet(xx, y, 0, sp*cenD/(abs(cenD-i)+3), r, cl, f);
      }
    }
    else {
      for (int i=0;i<n;i++) {
        float xx=x+dx*(i-(n/2));
        setBullet(xx, y, 0, sp*cenD/(abs(cenD-i)+3), r, cl, f);
      }
    }
  }
}

