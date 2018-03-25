



class Bullet {
  float x, y;
  float vx, vy;
  float r;
  boolean isDead=true;
  color cl;
  int power;

  int type;
  int timer;
  int bNum;
  float bSpeed;



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

  int getP() {
    return power;
  }

  Bullet() {
  }

  void setBullet(float x, float y, float vx, float vy, float r, color cl, int f) {
    this.x=x;
    this.y=y;
    this.vx=vx;
    this.vy=vy;
    this.r=r;
    this.cl=cl;
    this.power=f;

    type=0;
    //    power=r/2;
    //    println(r);

    isDead=false;
  }
  void setBullet(float x, float y, float vx, float vy, float r, color cl, int f,int type) {
    this.x=x;
    this.y=y;
    this.vx=vx;
    this.vy=vy;
    this.r=r;
    this.cl=cl;
    this.power=f;
    this.type=type;    
    //    power=r/2;
    //    println(r);

    isDead=false;
  }

  void setBullet(float x, float y, float vx, float vy, float r, color cl, int f, int type, int bNum, float sp, int time) {
    this.x=x;
    this.y=y;
    this.vx=vx;
    this.vy=vy;
    this.r=r;
    this.cl=cl;
    this.power=f;

    this.type=type;
    this.bNum=bNum;
    this.bSpeed=sp;
    this.timer=time;
    isDead=false;
  }


  void update() {
    if (isDead)return;

    if (type==1) {
      timer--;
      if (timer<=0) {
        fireFlowerP(bNum, bSpeed);
        isDead=true;
      }
    }
    if (type==2) {
      timer--;
      if (timer<=0) {
        fireFlowerE(bNum, bSpeed);
        isDead=true;
      }
    }
    if (type==BulletInc) {
      r+=0.5;
      power=(int)r;
    }
    x+=vx;
    y+=vy;

    //    if (x<0 || x>width || y<0 || y>height) {
    if (x<-OutsideRight || x>width+OutsideLeft || y<-OutsideUp || y>height+OutsideDown) {
      isDead=true;
    }
  }



  void kill() {
    isDead=true;
  }

  void draw() {
    if (isDead)return;

    fill(cl);
    ellipse(x, y, r*2, r*2);
  }


  void fireFlowerP(int n, float sp) {
    int dtheta=(int)360/n;
    int theta=0;
    float rr=r/2;
    for (int i=0;i<n;i++) {
      float rad=radians(theta);
      vx=sp*cos(rad);
      vy=sp*sin(rad);
      player.setBullet(x, y, vx, vy, rr, cl, power);
//      print(" "+theta);
      theta+=dtheta;
    }
  }
  void fireFlowerE(int n, float sp) {
    if(n==0)return;
    int dtheta=(int)360/n;
    int theta=0;
    float rr=r/2;
    for (int i=0;i<n;i++) {
      float rad=radians(theta);
      vx=sp*cos(rad);
      vy=sp*sin(rad);
      enemy.setBullet(x, y, vx, vy, rr, cl, power);
//      print(" "+theta);
      theta+=dtheta;
    }
  }
}

