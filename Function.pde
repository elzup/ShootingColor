

void keyPressed() {
  if (0<=key && key<256) {
    buf[key]=true;
  }
  else if (0<=keyCode && keyCode<256) {
    buf[keyCode]=true;
  }  
  //      if(keyCode==SHIFT)sp/=2;
  //      float v=player.getV();
  //      float dx=0;
  //      float dy=0;
  //      if(keyCode==UP)dy=-1;
  //      else if(keyCode==DOWN)dy=1;
  //      if(keyCode==RIGHT)dx=1;
  //      else if(keyCode==LEFT)dx=-1;
  //      player.move(dx,dy);


  if (key=='1' && gameMode==PROCESS_GAME) {
    enemy.reduceLife(50);
  }
  if (key=='2' && gameMode==PROCESS_GAME) {
    player.reduceLife(100);
  }
    if(key=='3'){
      MoverX--;
      println("<"+MoverX+","+MoverY+">");
    }
    if(key=='4'){
      MoverX++;
    }
    if(key=='5'){
      MoverY--;
    }
    if(key=='6'){
      MoverY++;
    }
}

void keyReleased() {
  if (0<=key && key<256) {
    buf[key]=false;
  }
  else if (0<=keyCode && keyCode<256) {
    buf[keyCode]=false;
  }
}

void setChangeTimer(int t, int b, int m, color cl) {
  book=new Book(b, m, cl);
  changeTimer=t;
  changeTimerM=t;
  setSpark(mouseX, mouseY, 100, t/2, clo[cloWhite]);
}


void updateChangeTimer() {
  if (changeTimer<1)return;
  changeTimer--;
  if (changeTimer<changeTimerM/2) {
    float r=sqrt(width*width+height*height)*2;
    //    float r=width;
    //    float rate=0;
    //    if(changeTimerM!=0){
    //       rate=(changeTimer*20/changeTimerM);
    //    }
    fill(book.cl);
    ellipse(0, 0, r-r*changeTimer*2/changeTimerM, r-r*changeTimer*2/changeTimerM);
    //    println (rate);
    if (changeTimer<changeTimerM/4) {
      fill(clo[cloBlack]);
      ellipse(0, 0, r-r*changeTimer*4/changeTimerM, r-r*changeTimer*4/changeTimerM);
    }
  }

  if (changeTimer<1) {
    gameMode=book.mode;
    if (book.stage!=-1) {
      setupGame(book.stage);
    }
  }
}

Book book;
class Book {
  int mode;
  int stage;
  color cl;
  Book() {
  }
  Book(int m, int s, color c) {
    mode=m;
    stage=s;
    cl=c;
  }
}


int openCheck() {
  if (clearFlag[0] && clearFlag[1] && !buStage[4].isOpen)return 4;
  if (clearFlag[2] && clearFlag[1] && !buStage[5].isOpen)return 5;
  if (clearFlag[2] && clearFlag[3] && !buStage[6].isOpen)return 6;
  if (clearFlag[4] && clearFlag[5] && !buStage[7].isOpen)return 7;
  if (clearFlag[5] && clearFlag[6] && !buStage[8].isOpen)return 8;
  if (clearFlag[7] && clearFlag[8] && !buStage[9].isOpen)return 9;
  return -1;
}

