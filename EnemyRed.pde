///////////////////////////////////////////////////////////////////////////// RED
class EnemyRed extends Enemy {
  int mode;


  EnemyRed(float x, float y, int life, int mode) {
    super(x, y, EnemyRadius, life, 0);
    this.cl=clo[mode];
    this.mode=mode;
    shotR=10;
    switch(mode) {
    case cloBlue:
      speed=0.5;
      break;
    case cloRed:
      break;
    case cloYellow:
      speed=0;
      shotR=30;
      this.life=maxLife=4000;
      this.r=600;
      this.y=-500;
      break;
    case cloGreen:
      this.r=100;
      break;
    case cloPurple:
      break;
    case cloOrange:
      break;
    case cloLightGreen:
      this.r=130;
      this.life=maxLife=3000;
      cureFlag=false;
      break;
    case cloBrawn:
      break;
    case cloGray:
      break;
    case cloWhite:
      break;
    default:
      break;
    }
  }


  void act() {
    if (actTimer<1) {
      actPat=((int)random(4))%4;
      if (state==2)actPat+=10;
      //        actPat=12;
      if (DEBUG_ACT!=-1) {
        actPat=DEBUG_ACT;
        //        actTimer=10000;
      }

      switch(actPat) {
      case 0:
        actTimer=100;
        break;
      case 1:
        int rr=(int)random(3);
        actTimer=300;
        if (rr<2)actTimer=100;
        break;
      case 2:
        actTimer=60;
        break;
      case 3:
        actTimer=300;
        break;
      case 10:
        actTimer=150;
        break;
      case 11:
        rr=(int)random(3);
        actTimer=300;
        if (rr<2)actTimer=100;
        break;
      case 12:
        actTimer=200;
        break;
      case 13:
        actTimer=300;
      default:
        break;
      }
      print (actPat);
    }


    switch(mode) {
    case cloBlue:
      switch(actPat) {
      case 0:
        if (actTimer%5==0)fire(1, 50-actTimer);
        break;
      case 1:
        //      dtheta=4*(1-lifeRate);

        move(0.5);

        //        if (shotTimer<0) {
        //          shotTimer=shotTimerLev;
        //          fire(11-(int)(lifeRate*10), 0);
        //        }
        //        if (shotTimer>0)shotTimer--;
        if (actTimer%3==0)fire(1, rd, 20);
        if (actTimer%10==0)setRd(-20, 20);
        break;

      case 2:
        if (actTimer%20==0) {
          setRd(true);
        }
        if (actTimer%5==0) {
          fire(1, rd, 15);
        }
        break;
      case 3:
        move(1);
        //        rd=(int)random(-30, 30);
        if (actTimer%30==0)setRd(-30, 30);
        if (actTimer/30%2==0 && actTimer%5==1) {
          fire(1, rd);
        }
        break;
      case 10:
        move(0.5);
        if (actTimer%4==0) {
          if (rd>0) {
            fire(2, 50-actTimer);
          }
          else {
            fire(2, actTimer-50);
          }
        }
        break;
      case 11:
        move(0.5);

        //        if (shotTimer<0) {
        //          shotTimer=shotTimerLev;
        //          fire(11-(int)(lifeRate*10), 0);
        //        }
        //        if (shotTimer>0)shotTimer--;
        if (actTimer%3==0)fire(1, rd, 20);
        if (actTimer%10==0)setRd(-20, 20);
        break;

      case 12:
        if (actTimer%20==0) {
          setRd(true);
        }
        if (actTimer%5==0) {
          //          rd=(int)random(-30, 30);
          fire(1, rd, 20);
        }
        break;
      case 13:
        move(1);
        //        rd=(int)random(-30, 30);
        if (actTimer%30==0)setRd(-30, 30);
        if (actTimer/30%2==0 && actTimer%5==0) {
          fire(1, rd);
        }
        break;
      default:
        break;
      }
      break;



    case cloRed:
      switch(actPat) {
      case 0:
        float ddx=random(-50, 50);
        if (actTimer%5==0)fire(1, 0, 10, ddx, 0);
        break;
      case 1:
        move(0.5);
        if (actTimer%50==0) {
          for (int i=0;i<10;i++) {
            setRd(-90, 90);
            fire(1, rd);
          }
        }
        break;

      case 2:
        if ((actTimer/20)%3==0) {
          setRd(-30, 30);
          fire(1, rd);
        }
        break;
      case 3:
        move(1);
        if (actTimer/30%2==0 && actTimer%5==0) {
          setRd(-30, 30);
//          print(rd);
          fire(1, rd);
        }
        break;
      case 10:
        ddx=random(-100, 100);
        if (actTimer%5==0)fire(1, 0, 10, ddx, 0);
        break;
      case 11:
        move(0.5);
        if (actTimer%50==0) {
          for (int i=0;i<20;i++) {
            setRd(-90, 90);
            fire(1, rd);
          }
        }
        break;

      case 12:
        if ((actTimer/20)%6==0) {
          setRd(-30, 30);
          fire(3, rd);
        }
        break;
      case 13:
        move(10);
        //        if (actTimer/30%2==0 && actTimer%5==0) {
        if (actTimer%5==0) {
          setRd(-30, 30);
//          print(rd);
          fire(1, rd, 4);
        }
        break;
      default:
        break;
      }
      break;



    case cloYellow:
      switch(actPat) {

      case 0:
        if (actTimer%10==0)fireShot(5, 0, 0, 300, 30, 30);
        break;
      case 1:
        //      dtheta=4*(1-lifeRate);
        if (actTimer%30==0) {
          setRd(-30, 30);
          float rrx=random(-200, 200);
          fire(1, rd, 15, rrx, 300, 30, 30);
        }
        break;

      case 2:
        if ((actTimer-5)%10==0)fire(4, 0);
        break;
      case 3:
        if (actTimer%70==0) {
          float rrx=random(-300, 300);
          fire(1, 0, 5, rrx, 300, 150, 50);
        }
        break;
      case 10:
        if (actTimer%10==0)fireShot(15);
        break;
      case 11:
        if (actTimer%20==0) {
          setRd(-30, 30);
          float rrx=random(-200, 200);
          fire(1, rd, 15, rrx, 300, 30, 30);
        }
        break;

      case 12:
        if ((actTimer-5)%12==0)fire(8, actTimer/5-actTimer/2);
        //      if ((actTimer-5)%20==0)fire(8, 4);
        //      else if ((actTimer+5)%20==0)fire(8, -4);
        break;
      case 13:
        if (actTimer==200) {
          float rrx=random(-300, 300);
          fire(1, 0, 5, rrx, 300, 300, 50);
        }
        break;
      default:
        break;
      }



      break;
    case cloGreen:
      switch(actPat) {

      case 0:
        if (actTimer%10==0)fireLine(5, 10, 20, 10, 10);
        break;
      case 1:
        move(1);
        if (actTimer%40==0) {
          fireLine(5, 7, 15, 10, 10);
        }
        break;

      case 2:
        move(1);
        if (actTimer%10==0) {
          fireLine(10-actTimer/10, 7, 15, 10, 10);
        }
        break;
      case 3:
        move(1);
        if (actTimer%40==0) {
          fireLine(15, 5, 15, 10, 10);
        }
        break;
      case 10:
        //        if (actTimer%10==0)fireLine(5,10,40-actTimer/10,10,10);
        if (actTimer==1)fireLine(30, 1, 20, 10, 10);
        break;
      case 11:
        move(1);
        if (actTimer%40==0) {
          //          print(actTimer%80);
          fireLine(5, 8+actTimer%80/8, 15, 10, 10);
        }
        break;

      case 12:
        move(1);
        if (actTimer%10==0) {
          fireLine(10-actTimer/10, 10, 50/(actTimer/10), 10, 10);
        }
        break;
      case 13:
        move(0.5);
        if (actTimer%50==0) {
          fireLine(15, 5, 30, 10, 10, true);
        }
        break;
      default:
        break;
      }
      break;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    case cloPurple:
      switch(actPat) {

      case 0:
        if (actTimer%5==0){
          setBullet(x, y, 0, /*vy*/ 5, /*r*/15, cl, /*power*/10, 2, /*num*/ 6,/*sp*/5,/*timer*/50);
        }
        break;
      case 1:
        move(0.5);
        if (actTimer%60==0){
          setBullet(x, y, 0, /*vy*/ 5, /*r*/15, cl, /*power*/10, 2, /*num*/ 7-actTimer/60,/*sp*/10,/*timer*/50);
        }
        break;

      case 2:
//        move(0.1);
        if (4<actTimer && actTimer<10 && actTimer%2==1){
          setBullet(x-r, y, 3, /*vy*/ 5, /*r*/15, cl, /*power*/10, 2, /*num*/ 7,/*sp*/5,/*timer*/50);
          setBullet(x+r, y, -3, /*vy*/ 5, /*r*/15, cl, /*power*/10, 2, /*num*/ 7,/*sp*/5,/*timer*/50);
        }
        break;
      case 3:
        move(1);
        if (actTimer%30==0) {
          int rr=(int)random(8)+2;
          int rrt=(int)random(30,120);
          setBullet(x+r, y, 0, /*vy*/ 5, /*r*/15, cl, /*power*/10, 2, /*num*/ rr,/*sp*/5,/*timer*/rrt);
        }
        break;
      case 10:
      move(0.3);
        if (actTimer%5==0){
          setBullet(x, y, 0, /*vy*/ 5, /*r*/15, cl, /*power*/10, 2, /*num*/ 6,/*sp*/5,/*timer*/100-actTimer/2);
        }
        break;
      case 11:
        move(0.5);
        if (actTimer%30==0){
          setBullet(x, y, 0, /*vy*/ 5, /*r*/15, cl, /*power*/10, 2, /*num*/ 11-actTimer/30,/*sp*/10,/*timer*/50);
        }
        break;
      case 12:
      move(0.5);
        if (4<(actTimer%30) && (actTimer%30)<10 && actTimer%2==1){
          setBullet(x-r, y, rd, /*vy*/ 5, /*r*/15, cl, /*power*/10, 2, /*num*/ 7,/*sp*/5,/*timer*/50);
          setBullet(x+r, y, -rd, /*vy*/ 5, /*r*/15, cl, /*power*/10, 2, /*num*/ 7,/*sp*/5,/*timer*/50);
        }
        if(actTimer%30==0)setRd(-10,10);
        break;
      case 13:
        move(1);
        if (actTimer%30==0) {
          int rr=(int)random(8)+2;
          int rrt=(int)random(30,120);
          setBullet(x+r, y, 0, /*vy*/ 5, /*r*/15, cl, /*power*/10, 2, /*num*/ 7,/*sp*/5,/*timer*/rrt);
        }
        break;
      }



      break;
    case cloOrange:
      switch(actPat) {

      case 0:
        if (actTimer%10==0)fireShot(10,3);
        break;
      case 1:
        move(0.5);
        if(actTimer%60==0){
          fire(3,0,8,0,0,3);
        }
        break;

      case 2:
        if ((actTimer-5)%20==0)fire(6, 0,8,0,0,3);
        break;
      case 3:
        move(1);
        if (actTimer<201 && actTimer>99 && actTimer%7==0) {
          fire(1, 0,10,0,0,3);
        }
        break;
      case 10:
        if (actTimer==1)fireShot(3,3);
        break;
      case 11:
        move(0.5);
        if(actTimer%60==0){
          fire(3,0,8,0,0,3);
        }
        break;

      case 12:
        if ((actTimer-5)%20==0)fire(2, actTimer/2-50,8,0,0,3);
        break;
      case 13:
        move(1.5);
        if (actTimer<250 && actTimer>50 && actTimer%7==0) {
          fireShot(1, 0,20,0,0,3);
        }
        break;
      default:
        break;
      }
      break;





    case cloLightGreen:
      
      switch(actPat) {

      case 0:
        cureLife(1);
        if (actTimer%10==0)fireShot(5);
        break;
      case 1:
        //      dtheta=4*(1-lifeRate);

        if (shotTimer<0) {
          shotTimer=shotTimerLev;
          fire(11-(int)(lifeRate*10), 0);
        }
        if (shotTimer>0)shotTimer--;
        break;

      case 2:
        if ((actTimer-5)%10==0)fire(6, 0);
        break;
      case 3:
      cureLife(1);
        move(1,0,(150-abs(150-actTimer))*3);
        break;
      case 10:
      cureFlag=false;
      cureLife(1);
        if (actTimer%10==0)fireShot(10);
        break;
      case 11:

        move(0.5);
        if (shotTimer<0) {
          shotTimer=shotTimerLev;
          fire(11-(int)(lifeRate*10), 0);
        }
        if (shotTimer>0)shotTimer--;
        break;

      case 12:
        if ((actTimer-5)%12==0)fire(8, actTimer/2-50);
        break;
      case 13:
      cureFlag=true;
        move(1,0,(150-abs(150-actTimer))*5);
        break;
      default:
        break;
      }
      break;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    case cloBrawn:
      switch(actPat) {

      case 0:
        if (actTimer%10==0)fireShot(10);
        break;
      case 1:
        //      dtheta=4*(1-lifeRate);

        move(0.5);
        if (shotTimer<0) {
          shotTimer=shotTimerLev;
          fire(11-(int)(lifeRate*10), 0);
        }
        if (shotTimer>0)shotTimer--;
        break;

      case 2:
        if ((actTimer-5)%10==0)fire(6, 0);
        break;
      case 3:
        move(1);
        if (actTimer<201 && actTimer>99 && actTimer%7==0) {
          fire(1, 0);
        }
        break;
      case 10:
        if (actTimer%10==0)fireShot(15);
        break;
      case 11:
        //      dtheta=4*(1-lifeRate);

        move(0.5);
        if (shotTimer<0) {
          shotTimer=shotTimerLev;
          fire(11-(int)(lifeRate*10), 0);
        }
        if (shotTimer>0)shotTimer--;
        break;

      case 12:
        if ((actTimer-5)%12==0)fire(8, actTimer/2-50);
        //      if ((actTimer-5)%20==0)fire(8, 4);
        //      else if ((actTimer+5)%20==0)fire(8, -4);
        break;
      case 13:
        move(3);
        if (actTimer<251 && actTimer>50 && actTimer%7==0) {
          fireShot(10);
        }
        break;
      default:
        break;
      }
      break;



    case cloGray:
      switch(actPat) {

      case 0:
        if (actTimer%10==0)fireShot(10);
        break;
      case 1:
        //      dtheta=4*(1-lifeRate);

        move(0.5);
        if (shotTimer<0) {
          shotTimer=shotTimerLev;
          fire(11-(int)(lifeRate*10), 0);
        }
        if (shotTimer>0)shotTimer--;
        break;

      case 2:
        if ((actTimer-5)%10==0)fire(6, 0);
        break;
      case 3:
        move(1);
        if (actTimer<201 && actTimer>99 && actTimer%7==0) {
          fire(1, 0);
        }
        break;
      case 10:
        if (actTimer%10==0)fireShot(15);
        break;
      case 11:
        //      dtheta=4*(1-lifeRate);

        move(0.5);
        if (shotTimer<0) {
          shotTimer=shotTimerLev;
          fire(11-(int)(lifeRate*10), 0);
        }
        if (shotTimer>0)shotTimer--;
        break;

      case 12:
        if ((actTimer-5)%12==0)fire(8, actTimer/2-50);
        //      if ((actTimer-5)%20==0)fire(8, 4);
        //      else if ((actTimer+5)%20==0)fire(8, -4);
        break;
      case 13:
        move(3);
        if (actTimer<251 && actTimer>50 && actTimer%7==0) {
          fireShot(10);
        }
        break;
      default:
        break;
      }
      break;




    case cloWhite:
      switch(actPat) {

      case 0:
        if (actTimer%10==0)fireShot(10);
        break;
      case 1:
        //      dtheta=4*(1-lifeRate);

        move(0.5);
        if (shotTimer<0) {
          shotTimer=shotTimerLev;
          fire(11-(int)(lifeRate*10), 0);
        }
        if (shotTimer>0)shotTimer--;
        break;

      case 2:
        if ((actTimer-5)%10==0)fire(6, 0);
        break;
      case 3:
        move(1);
        if (actTimer<201 && actTimer>99 && actTimer%7==0) {
          fire(1, 0);
        }
        break;
      case 10:
        if (actTimer%10==0)fireShot(15);
        break;
      case 11:
        //      dtheta=4*(1-lifeRate);

        move(0.5);
        if (shotTimer<0) {
          shotTimer=shotTimerLev;
          fire(11-(int)(lifeRate*10), 0);
        }
        if (shotTimer>0)shotTimer--;
        break;

      case 12:
        if ((actTimer-5)%12==0)fire(8, actTimer/2-50);
        //      if ((actTimer-5)%20==0)fire(8, 4);
        //      else if ((actTimer+5)%20==0)fire(8, -4);
        break;
      case 13:
        move(3);
        if (actTimer<251 && actTimer>50 && actTimer%7==0) {
          fireShot(10);
        }
        break;
      default:
        break;
      }
      break;




    default:
      break;
    }
    actTimer--;
  }

  void move(float speed) {
    if (this.speed==0)return;
    dtheta=speed*this.speed;
    theta+=dtheta;
    float rad=radians(theta);
    x=width*2*cos(rad)/5+width/2;
    y=height/12*cos(rad*2+HALF_PI)+height/6;
  }
  void move(float speed,float ddx,float ddy) {
    if (this.speed==0)return;
    dtheta=speed*this.speed;
    theta+=dtheta;
    float rad=radians(theta);
    x=width*2*cos(rad)/5+width/2+ddx;
    y=height/12*cos(rad*2+HALF_PI)+height/6+ddy;
  }
}

