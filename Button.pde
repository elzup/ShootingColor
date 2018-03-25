
Button buStart, buNext, buContinue, buReset;
StageButton[] buStage;
WeaponButton[] buWeapon;

class Button {
  float x, y;
  float w, h;
  String name;
  color backColor, borderColor;
  color backColorOn, borderColorOn;
  color stringColor;
  boolean isOn;
  int id;
  float feeling;

  Button() {
  };

  Button(int id, float x, float y, float w, float h, String st, color bac, color boc, color baco, color boco, 
  color sc, float f) {
    this.id=id;
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    name=st;
    backColor=bac;
    borderColor=boc;
    backColorOn=baco;
    borderColorOn=boco;
    stringColor=sc;
    feeling=f;
  }


  int checkOn() {
    if (x-w/2<mouseX && mouseX<x+w/2 && y-h/2<mouseY && mouseY<y+h/2) {
      isOn=true;
    }
    else {
      isOn=false;
    }
    if (mousePressed && isOn)return id;
    return 0;
  }


  void draw() {
    rectMode(CENTER);
    if (!isOn) {
      fill(borderColor);
      rect(x, y, w+5, h+5);
      fill(backColor);
      rect(x, y, w, h);
    }
    else {
      fill(borderColorOn);
      rect(x, y, w+5, h+5);
      fill(backColorOn);
      rect(x, y, w, h);
    }
    textSize(h-2);
    fill(stringColor);
    text(name, x-w/2+feeling, y+10);
    rectMode(CORNER);
  }
}

class StageButton extends Button {
  color mainColor;
  boolean isclear, isOpen;
  int score;

  StageButton(int id, float x, float y, float w, float h, String st, color clo, boolean o) {
    super();
    this.id=id;
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    name=st;
    isOpen=o;
    isclear=false;
    mainColor=clo;
    score=0;

    //    backColor=clo[cloGray];
    //    borderColor=clo[cloGray];
    //    backColorOn=clo[cloBlack];
    //    borderColorOn=clo[cloGray];


    //    if (isOpen) {
    openS(o);
    //  }
  }

  void openS(boolean o) {
    isOpen=o;
    backColor=clo[cloBlack];
    borderColor=mainColor;
    backColorOn=mainColor;
    borderColorOn=clo[cloWhite];
  }

  void clearS() {
    isclear=true;
    backColor=mainColor;
    borderColor=clo[cloWhite];
    backColorOn=clo[cloWhite];
    borderColorOn=mainColor;
  }

  int checkOn() {
    if (x-w/2<mouseX && mouseX<x+w/2 && y-h/2<mouseY && mouseY<y+h/2) {
      isOn=true;
    }
    else {
      isOn=false;
    }
    if (mousePressed && isOn && isOpen && !isclear)return id+1;
    return 0;
  }

  void draw() {
    if (!isOpen)return;
    rectMode(CENTER);
    strokeJoin(BEVEL);
    if (!isOn) {
      fill(borderColor);
      rect(x, y, w+5, h+5);
      fill(backColor);
      rect(x, y, w, h);
      if(isclear){
        fill(clo[cloWhite]);
        textSize(20);
        text(score,x+MoverX,y+MoverY);
      }
    }else {
      fill(borderColorOn);
      rect(x, y, w+5, h+5);
      fill(backColorOn);
      rect(x, y, w, h);
    }
    //    textSize(h-2);
    //    fill(stringColor);
    //    text(name, x-w/2+8, y+10);
    rectMode(CORNER);
    strokeJoin(MITER);
    //    print(id);
    if (id>CreatedSign) {
      fill(clo[cloGray]);
      textSize(15);
      text("NotCreated", x, y);
      //      print(id);
    }
  }
}

class WeaponButton extends Button {
  color mainColor;
  boolean isSelect, isOpen;
  float r;

  WeaponButton(int id, float x, float y, color clo) {
    super();
    this.id=id;
    this.x=x;
    this.y=y;
    r=PanelR;
    isOpen=false;
    isSelect=false;
    //    isMode=false;
    mainColor=clo;
  }
  WeaponButton(int id, float x, float y, color clo, boolean boo) {
    super();
    this.id=id;
    this.x=x;
    this.y=y;
    r=PanelR;
    isOpen=boo;
    isSelect=false;
    //    isMode=false;
    mainColor=clo;
    if (isOpen)openPanel();
  }

  void openPanel() {
    if (id>CreatedSign)return;
    isOpen=true;
    backColor=clo[cloBlack];
    borderColor=mainColor;
    backColorOn=mainColor;
    borderColorOn=clo[cloWhite];
  }

  //  void selectPanel() {
  //    isSelect=true;
  //    backColor=mainColor;
  //    borderColor=clo[cloWhite];
  //    backColorOn=clo[cloWhite];
  //    borderColorOn=mainColor;
  //  }

  int checkOn() {
    if (!isOpen)return 0;
    float dx=mouseX-x;
    float dy=mouseY-y;
    float dr=r/2;
    if (dx*dx+dy*dy<dr*dr)isOn=true;
    else isOn=false;
    if (mousePressed && isOn)return id+1;
    return 0;
  }

  void draw() {
    rectMode(CENTER);
    strokeJoin(BEVEL);
    if (!isOn) {
      fill(borderColor);
      ellipse(x, y, r, r);
      fill(backColor);
      ellipse(x, y, r-PanelB, r-PanelB);
    }
    else {
      fill(borderColorOn);
      ellipse(x, y, r, r);
      fill(backColorOn);
      ellipse(x, y, r-PanelB, r-PanelB);
    }
    //    textSize(h-2);
    //    fill(stringColor);
    //    text(name, x-w/2+8, y+10);
    rectMode(CORNER);
    strokeJoin(MITER);
    if (id>CreatedSign) {
      fill(clo[cloGray]);
      textSize(10);
      text("NotCreated", x-10, y);
      //      print(id);
    }
  }
}


void buttonSetup() {
  String st="START";
  buStart=new Button(1, width/2, height/2, 100, 30, st, clo[cloBlack], clo[cloWhite], clo[cloGray], clo[cloWhite], clo[cloWhite], 8);
  st="NEXT";
  buNext=new Button(1, width/2, height/2, 100, 30, st, clo[cloBlack], clo[cloWhite], clo[cloGray], clo[cloWhite], clo[cloWhite], 10);
  st="CONTINUE";
  buContinue=new Button(2, width/2, height/2-20, 200, 30, st, clo[cloBlack], clo[cloWhite], clo[cloGray], clo[cloWhite], clo[cloWhite], 30);
  st="NEWGAME";
  buReset=new Button(5, width/2, height/2+20, 200, 30, st, clo[cloBlack], clo[cloWhite], clo[cloGray], clo[cloWhite], clo[cloWhite], 30);
  float ww=width/6;
  float hh=width/10;
  float dw=(width-ww*4)/5;
  float dh=50;
  float lw=(width-(ww+dw)*4)/2;

  boolean openStart=StageOpenStart;

  buStage[0]=new StageButton(0, dw+ww/2+(ww+dw)*0, 300, ww, hh, "Blue", clo[cloBlue], true);
  buStage[1]=new StageButton(1, dw+ww/2+(ww+dw)*1, 300, ww, hh, "Red", clo[cloRed], true);
  buStage[2]=new StageButton(2, dw+ww/2+(ww+dw)*2, 300, ww, hh, "Yellow", clo[cloYellow], true);
  buStage[3]=new StageButton(3, dw+ww/2+(ww+dw)*3, 300, ww, hh, "Green", clo[cloGreen], true);
  float dd=(ww+dw)/2;
  buStage[4]=new StageButton(4, dw+ww/2+(ww+dw)*0+dd, 300-dh, ww, hh, "Purple", clo[cloPurple], openStart);
  buStage[5]=new StageButton(5, dw+ww/2+(ww+dw)*1+dd, 300-dh, ww, hh, "Orange", clo[cloOrange], openStart);
  buStage[6]=new StageButton(6, dw+ww/2+(ww+dw)*2+dd, 300-dh, ww, hh, "Ligth-Green", clo[cloLightGreen], openStart);

  buStage[7]=new StageButton(7, dw+ww/2+(ww+dw)*0+dd*2, 300-dh*2, ww, hh, "Brawn", clo[cloBrawn], openStart);
  buStage[8]=new StageButton(8, dw+ww/2+(ww+dw)*1+dd*2, 300-dh*2, ww, hh, "Gray", clo[cloGray], openStart);
  buStage[9]=new StageButton(9, dw+ww/2+(ww+dw)*0+dd*3, 300-dh*3, ww, hh, "White", clo[cloWhite], openStart);

  boolean mo=ButtonOpenStart;
  for (int i=0;i<10;i++) {
    //    buWeapon[i]=new WeaponButton(i,PanelX+(PanelR+PanelDX)*i%5 , PanelY+(PanelR+PanelDY)*(i/5),clo[i],mo);
    buWeapon[i]=new WeaponButton(i, PanelX+(PanelR+PanelDX)*(i%5), PanelY+(PanelR+PanelDY)*(i/5), clo[i], mo);
  }
}

