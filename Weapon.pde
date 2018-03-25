Weapon[] weapon;

class Weapon {
  int ID;
  int power;
  float speed;
  float r;
  color cl;
  int type;
  int delays;

  boolean isSet;
  int num;

  int timer;
  boolean can, using;
  int incS, decS;
  int shotTimer;

  Weapon() {
    ID=-1;
  };
  Weapon(int id, int power, float speed, int delays, float r, int type) {
    this.ID=id;
    this.power=power;
    this.speed=speed;
    this.delays=delays;
    this.r=r;
    this.type=type;
    cl=clo[id];
    incS=(int)MeterMax/200;
    decS=(int)MeterMax/200;
  }
  Weapon(int id, int power, float speed, int delays, float r, int type, int incS, int decS) {
    this.ID=id;
    this.power=power;
    this.speed=speed;
    this.delays=delays;
    this.r=r;
    this.type=type;
    cl=clo[id];
    this.incS=incS;
    this.decS=decS;
  }

  void setting(int n) {
    num=n;
    isSet=true;
    can=true;
    using=false;
    timer=MeterMax;
  }

  void update(boolean flag, float x, float y) {
    if (flag) {
      if (can) {
        timer-=decS;
        using=true;
      }
      if (using) {
        if (type==0 && shotTimer==0) {
          setBullet(x, y, 0, -speed, r, cl, power);
          //          print (power);
          shotTimer=delays;
        }
        if (type==1 && shotTimer==0) {
          fire(3, 0, speed, x, y);
          shotTimer=delays;
        }
        if (type==2 && shotTimer==0) {
          for (int k=-2;k<3;k++) {
            setBullet(x+k*10, y, 0, -speed, r, cl, power);
          }
          shotTimer=delays;
        }
        if (type==3 && shotTimer==0) {
          setBullet(x, y, 0, -speed, r, cl, power, 3);
          shotTimer=delays;
        }
        if (type==5 && shotTimer==0) {
          setBullet(x,y,0,-speed, r, cl,power, 1,10, 10,70);        //type 1=flower
          shotTimer=delays;
        }
        if (type==4 && shotTimer==0) {
          setBullet(x, y, 0, -speed, r, cl, power, 4);
          shotTimer=delays;
        }
        if (shotTimer>0)shotTimer--;
      }
    }
    else {
      using=false;
      if (can && timer<MeterMax) {
        can=false;
      }
    }
    if (timer<0) {
      can=false;
      using=false;
      timer=0;
      shotTimer=0;
    }
    if (!using && timer<MeterMax)timer+=incS;
    if (timer>=MeterMax) {
      timer=MeterMax;
      can=true;
    }

    meterDraw();
    //    println(timer);
  }

  void fire(int num, int dt, float sp, float x, float y) {
    //      println((int)(lifeRate*10));
    for (int i=1;i<num+1;i++) {
      float rad;
      if (num%2==1) {
        rad=radians(15*(i/2*((i%2)*2-1))+dt);
      }
      else {
        rad=radians(7.5+15*(i/2*((i%2)*2-1))+dt);
      }
      float vx=-sp*sin(rad)/2;
      float vy=-sp*cos(rad)/2;
      setBullet(x, y, vx, vy, 10, cl, 10);
    }
  }


  void meterDraw() {
    float x=MeterX+num*(MeterW+MeterDW);
    float h=timer*MeterH/MeterMax;
    float y=MeterY+(MeterH-h);

    fill(cl);
    if (!can)fill(clo[cloGray]);
    rect(x, y, MeterW, h);
    //    if(gameFlag==PROCESS_MENU){
    //      textsize(10);
    //      fill(clo[cloGray]);
    //      text("")
    //    }
  }
  void setBullet(float x, float y, float vx, float vy, float r, color cl, int f) {
    for (int i=0;i<playerBullet.length;i++) {
      if (playerBullet[i].isDead()) {
        playerBullet[i].setBullet(x, y, vx, vy, r, cl, f);
        //        print (f);
        break;
      }
    }
  }
  void setBullet(float x, float y, float vx, float vy, float r, color cl, int f,int type) {
    int ttt=type;
    if(type==5){
      ttt=2;
    }
    for (int i=0;i<playerBullet.length;i++) {
      if (playerBullet[i].isDead()) {
        playerBullet[i].setBullet(x, y, vx, vy, r, cl, f,type);
        //        print (f);
        break;
      }
    }
  }
  void setBullet(float x, float y, float vx, float vy, float r, color cl, int f, int type, int bNum, float sp, int time) {        //type 1=flower
    for (int i=0;i<playerBullet.length;i++) {
      if (playerBullet[i].isDead()) {
        playerBullet[i].setBullet(x, y, vx, vy, r, cl, f, type, bNum, sp, time);
        //        print (f);
        break;
      }
    }
  }
}


void weaponSetup() {
  weapon=new Weapon[12];
  //  Weapon(int id,int power,float speed,int delays,float r,int type,int incS,int decS){
  //  Weapon(int id, int power, float speed, int delays, float r, int type) {
  weapon[cloBlue]=new Weapon(0, 5, 20, 5, 5, 0);                      //Beam
  weapon[cloRed]=new Weapon(1, 30, 10, 20, 10, 1);                      //kakusan
  weapon[cloYellow]=new Weapon(2, 50, 3, 20, 20, 0, 10, MeterMax);                      //big
  weapon[cloGreen]=new Weapon(3, 20, 10, 20, 7, 2, 10, MeterMax/7/7);                      //line
  weapon[cloPurple]=new Weapon(4, 30, 5, 20, 15, BulletFlower, 10, MeterMax);                      //flower
  weapon[cloOrange]=new Weapon(5,/*power*/ 40, /*speed*/10,/*delays*/ 20,/*r*/ 1, /*type*/BulletInc,5,40);                      //inc
  weapon[cloLightGreen]=new Weapon(6,/*power*/ 20, /*speed*/10,/*delays*/ 30,/*r*/ 1, /*type*/BulletCure,5,40);                      //cure
  weapon[cloBrawn]=new Weapon(7,/*power*/ 5, /*speed*/20,/*delays*/ 5,/*r*/ 5, /*type*/BulletInc,10,MeterMax);                      //
  weapon[cloGray]=new Weapon(8,/*power*/ 5, /*speed*/20,/*delays*/ 5,/*r*/ 5, /*type*/BulletInc,10,MeterMax);                      //
  weapon[cloWhite]=new Weapon(9,/*power*/ 5, /*speed*/20,/*delays*/ 5,/*r*/ 5, /*type*/BulletInc,10,MeterMax);                      //
}

