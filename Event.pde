

void startMenu() {
  int num=0;
  num+=buStart.checkOn();

  if (num!=0 && changeTimer==0) {
    //gameMode=num;
    setChangeTimer(200, num, -1, clo[cloWhite]);
  }

  fill(clo[cloWhite]);
  buStart.draw();

  textSize(32);
  text("ShootingColor", width/2-100, height/2-50);
}


int pID=2;
void stageSelect() {
  if (demoPlayer.isDead) {
    demoPlayer=new DemoPlayer(DEMO_X+DEMO_W/2, DEMO_Y+DEMO_H/2, PlayerRadius, false, clo[cloWhite]);
    for (int i=0;i<3;i++) {
      demoPlayer.weapon[i].ID=-1;
    }
    for (int i=0;i<3;i++) {
      if (player.weapon[i].ID!=-1)demoPlayer.weapon[i]=player.weapon[i];
    }
    for (int i=0;i<playerBullet.length;i++) {
      playerBullet[i]=new Bullet();
      //      demoPlayer.setWeapon(0,weapon[cloBlue]);
    }
  }
  textSize(12);
  fill(clo[cloWhite]);
  float x=MeterX+0*(MeterW+MeterDW);
  float y=MeterY-12;
  text('a', x, y);
  x+=MeterW+MeterDW;
  text('s', x, y);
  x+=MeterW+MeterDW;
  text("d  SpaceKey", x, y);
  
  textSize(30);
  text("score:"+totalScore,width/2-30,height-10);
  textSize(15);
  if(continueCount+retryCount>0){
  text("retry:"+retryCount+"  continue:"+continueCount,width/2-30,height-40);
  }
  

  int openC=0;
  int k=0;
  for (int i=0;i<10;i++) {
    openC+=buStage[i].checkOn();        //ID+1
    buStage[i].draw();
    k+=buWeapon[i].checkOn();
    buWeapon[i].draw();
  }

  demoPlayer.update();

  if (k!=0) {
    if (demoPlayer.checkW(k-1)) {
      demoPlayer.setWeapon((++pID)%3, weapon[k-1]);
    }
    //    print (pID);
  }

  if (openC!=0 && changeTimer==0) {
    setChangeTimer(200, PROCESS_GAME, openC-1, clo[openC-1]);
    //    gameMode=PROCESS_GAME;
  }

  demoPlayer.fire();
  demoPlayer.draw();
  for (int i=0;i<playerBullet.length;i++) {
    playerBullet[i].update();
    playerBullet[i].draw();
  }
  //  setupGame(0);
  //  gameMode=PROCESS_GAME;
}



void gameReset() {
  totalScore=0;
}



void updateSystem() {
  for (int i=0;i<spark.length;i++) {
    spark[i].draw();
  }
  updateChangeTimer();
}

