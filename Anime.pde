class Spark {
  float x, y;
  int timer, timerMax;
  color clo;
  float r;
  boolean isOn;

  Spark() {
  }

  Spark(float x, float y, float r, int timer, color clo) {
    this.x=x;
    this.y=y;
    this.r=r;
    this.timer=timerMax=timer;
    this.clo=clo;
    isOn=true;
  }

  void draw() {
    timer--;
    if (timer<1)isOn=false;
    if (!isOn)return;
    float rate=100*timer/timerMax;
    fill(clo, rate);
    r+=rate/100;
    ellipse(x, y, r*2, r*2);
  }
}


void setSpark(float x, float y, int r, int t, color clo) {
  for (int j=0;j<spark.length;j++) {
    if (!spark[j].isOn) {
      spark[j]=new Spark(x, y, r, t, clo);
      break;
    }
  }
}

