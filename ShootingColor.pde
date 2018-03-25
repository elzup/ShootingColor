final float PlayerRadius=5;
final int PlayerBulletCount=100;
final int PlayerLife=100;

final int WindowW=720;
final int WindowH=720;

final float EnemyRadius=60;
final int EnemyBulletCount=200;
final int EnemyLife=1000;

final int PlayerRemains=3;
final float PlayerSpeed=5;

final int MODE_RED=0;
final int MODE_BLUE=1;
final int MODE_GREEN=2;
final int MODE_YELLOW=3;
final int MODE_PURPLE=4;

final int PROCESS_START=0;
final int PROCESS_MENU=1;
final int PROCESS_GAME=2;
final int PROCESS_CLEAR=3;
final int PROCESS_OVER=5;



color[] clo;

int gameMode, stageFlag;
int continueCount, retryCount;
int totalScore;
boolean[] clearFlag;
boolean buf[];

//color clo[cloRed], clo[cloBlue], clo[cloGreen], clo[cloYellow], clo[cloPurple], clo[cloBlack], clo[cloWhite], clo[cloGray];

Player player;
Bullet[] playerBullet=new Bullet[PlayerBulletCount];

EnemyRed enemy;
//EnemyBlue enemyBlue;
//EnemyYellow enemy;
//EnemyGreen enemy;
Bullet[] enemyBullet=new Bullet[EnemyBulletCount];

DemoPlayer demoPlayer;

Spark[] spark=new Spark[100];
int changeTimer, changeTimerM, changeBook, changeBookStage;

void setup() {
  size(720, 720);
//  frameRate(100);
  buf=new boolean[256];
  demoPlayer=new DemoPlayer(0, 0, 0, true, 0);
  for (int i=0;i<256;i++)buf[i]=false;
  buStage=new StageButton[10];
  buWeapon=new WeaponButton[10];
  totalScore=0;
  for (int i=0;i<spark.length;i++) {
    spark[i]=new Spark();
  }
  player=new Player();

  colorMode(HSB, 360, 100, 100);
  smooth();
  noStroke();
  //  gameMode=PROCESS_MENU;
  gameMode=PROCESS_START;
  stageFlag=-1;
  clearFlag=new boolean[10];
  for (int i=0;i<clearFlag.length;i++)clearFlag[i]=false;
  book=new Book();

  colorSetup();
  weaponSetup();
  buttonSetup();
}

void setupGame(int mode) {
  frameCount=0;
  stageFlag=mode;

  float centerX=width/2;
  float offsetY=height/5;

  enemy=new EnemyRed(centerX, offsetY, EnemyLife, mode);



  player=new Player(centerX, height, PlayerRadius, PlayerLife, clo[cloWhite]);
  for (int i=0;i<playerBullet.length;i++) {
    playerBullet[i]=new Bullet();
  }
  for (int i=0;i<enemyBullet.length;i++) {
    enemyBullet[i]=new Bullet();
  }
  for (int i=0;i<3;i++) {
    if (demoPlayer.weapon[i].ID!=-1)player.weapon[i]=demoPlayer.weapon[i];
    else player.weapon[i].ID=-1;
  }
}

void draw() {
  background(0, 0, 2);
  switch(gameMode) {
  case PROCESS_START:
    startMenu();
    break;
  case PROCESS_MENU:
    stageSelect();
    break;
  case PROCESS_GAME:
    updateGame();
    break;
  case PROCESS_OVER:
    updateGameOver();
    break;
  case PROCESS_CLEAR:
    updateGameClear();
    break;
  default:
    break;
  }
  updateSystem();
}



void updateGameOver() {
  enemy.update();
  enemy.draw();
  for (int i=0;i<enemyBullet.length;i++) {
    enemyBullet[i].update();
    enemyBullet[i].draw();
  }

  int push=0;
  push+=buContinue.checkOn();
  push+=buReset.checkOn();
  buContinue.draw();
  buReset.draw();

  if (push==2 && changeTimer==0) {
    continueCount++;
    player.reborn();
    gameMode=PROCESS_GAME;
  }
  else if (push==5 && changeTimer==0) {
    setChangeTimer(200, 0, -1, clo[cloWhite]);
  }

  fill(clo[cloWhite]);
  textSize(32);
  text("GameOver", width/2-90, height/2-50);
}

void updateGameClear() {
  player.update();
  player.draw();
  for (int i=0;i<playerBullet.length;i++) {
    playerBullet[i].update();
    playerBullet[i].draw();
  }
  
  int resultScore=player.resultScore();
  text(resultScore,width/2-50,height/2+50);
  
  int push=0;
  push=buNext.checkOn();
  buNext.draw();

  fill(clo[cloWhite]);
  textSize(32);
  text("clear!", width/2-50, height/2-50);

  if (push!=0) {
    buStage[stageFlag].score=resultScore;
    totalScore+=resultScore;
    gameMode=push;
    buStage[stageFlag].clearS();
    clearFlag[stageFlag]=true;
    buWeapon[stageFlag].openPanel();
    int openNum=openCheck();
    if (openNum!=-1) {
      buStage[openNum].openS(true);
    }
  }

  //  textSize(10);
  //  text("press R key to restart.", width/2-58, height/2+20);
  //  if (keyPressed && key =='r') {
  //    setupGame(stageFlag);
  //  }
}

void updateGame() {
  enemy.update();
  player.update();
  for (int i=0;i<playerBullet.length;i++) {
    playerBullet[i].update();
  }
  for (int i=0;i<enemyBullet.length;i++) {
    enemyBullet[i].update();
  }

  if (frameCount<100) {
    fill(clo[cloWhite]);
    textSize(32);
    text("Ready", width/2-46, height/2);
  }
  else {
    if (frameCount<150) {
      fill(clo[cloWhite]);
      textSize(32);
      text("Go!", width/2-24, height/2);
    }

    player.fire();

    //    enemy.fire();

    {
      float dx=enemy.getX()-player.getX();
      float dy=enemy.getY()-player.getY();
      float r=enemy.getR()+player.getR();
      if (dx*dx+dy*dy<r*r) {
        player.reduceLife(50);
      }
    }

    for (int i=0;i<enemyBullet.length;i++) {
      if (enemyBullet[i].isDead())continue;

      float dx=enemyBullet[i].getX()-player.getX();
      float dy=enemyBullet[i].getY()-player.getY();
      float r=enemyBullet[i].getR()+player.getR();

      if (dx*dx+dy*dy<r*r) {
        //        print((int)enemyBullet[i].power);
        player.reduceLife(enemyBullet[i].getP());
        enemyBullet[i].kill();
        setSpark(enemyBullet[i].getX(), enemyBullet[i].getY(), (int)enemyBullet[i].getR()*5, 100, enemyBullet[i].cl);
      }
    }

    for (int i=0;i<playerBullet.length;i++) {
      if (playerBullet[i].isDead())continue;

      float dx=playerBullet[i].getX()-enemy.getX();
      float dy=playerBullet[i].getY()-enemy.getY();
      float r=playerBullet[i].getR()+enemy.getR();

      if (dx*dx+dy*dy<r*r) {
        playerBullet[i].kill();
        if(enemy.cureFlag){
          enemy.cureLife((int)playerBullet[i].power);
        }
        else enemy.reduceLife(playerBullet[i].getP());
        if(playerBullet[i].type==BulletCure)player.cureLife(playerBullet[i].power);
        setSpark(playerBullet[i].getX(), playerBullet[i].getY(), 10, 100, playerBullet[i].cl);
      }
    }
  }

  enemy.draw();
  player.draw();
  for (int i=0;i<playerBullet.length;i++) {
    playerBullet[i].draw();
  }
  for (int i=0;i<enemyBullet.length;i++) {
    enemyBullet[i].draw();
  }
}