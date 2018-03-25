final int DEMO_X=WindowW*4/5-50;
final int DEMO_W=WindowW/5;
final int DEMO_Y=WindowH-WindowW/5-50;
final int DEMO_H=WindowW/5;

final int DEBUG_ACT=-1;              //-1
//final int DEBUG_ACT=-1;              //-1
final boolean ButtonOpenStart=false;
final boolean StageOpenStart=false;

final int CreatedSign=6;

final int StageScoreMax=100000;

int MoverX=-23;
int MoverY=27;

final int cloBlue=0;
final int cloRed=1;
final int cloYellow=2;
final int cloGreen=3;
final int cloPurple=4;
final int cloOrange=5;
final int cloLightGreen=6;
final int cloBrawn=7;
final int cloGray=8;
final int cloWhite=9;
final int cloBlack=10;


final int BulletNormal=0;
final int BulletBomP=1;
final int BulletBomE=2;
final int BulletInc=3;
final int BulletCure=4;
final int BulletFlower=5;

final int MeterX=115;
final int MeterW=10;
final int MeterH=40;
final int MeterY=WindowH-MeterH;
final int MeterDW=3;

final int PanelX=60;
final int PanelY=WindowH/2+30;
final int PanelDX=10;
final int PanelDY=10;
final int PanelR=50;
final int PanelB=10;

final float OutsideUp=500;
final float OutsideDown=200;
final float OutsideRight=10;
final float OutsideLeft=10;

final int MeterMax=2000;

void colorSetup() {
  clo=new color[12];
  colorMode(RGB, 255, 255, 255);
  clo[cloBlue]=color(0, 0, 255);
  clo[cloRed]=color(255, 0, 0);
  clo[cloYellow]=color(255, 255, 0);
  clo[cloGreen]=color(0, 180, 0);
  clo[cloPurple]=color(200, 0, 230);
  clo[cloOrange]=color(255, 180, 0);
  clo[cloLightGreen]=color(100, 255, 0);
  clo[cloBrawn]=color(100, 50, 20);
  clo[cloGray]=color(100, 100, 100);
  clo[cloBlack]=color(0, 0, 0);
  clo[cloWhite]=color(255, 255, 255);
  //  cloRed=color(0, 100, 100);
  //  cloBlue=color(200, 100, 100);
  //  cloGreen=color(150, 100, 100);
  //  cloYellow=color(100, 100, 100);
  //  cloBlack=color(0, 0, 0);
  //  cloWhite=color(0, 0, 100);
  //  cloGray=color(0, 0, 50);
  colorMode(HSB, 360, 100, 100);
}


