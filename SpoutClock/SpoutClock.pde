import spout.*;

int MARGIN = 20;
int clockWidth = 384;
int clockHeight= 384;
Clock myClock = new Clock();
Spout spout;

void setup() {
  size(640,640,P3D);
  textureMode(NORMAL);
  spout = new Spout(this);
  spout.createSender("Spout Processing");
  
  stroke(255);
  smooth();
  frameRate(30);
}
 
void draw() {
  background(0);
  myClock.getTime();

  pushMatrix();
  translate(128,128);
  myClock.draw();
  popMatrix();

  spout.sendTexture();

}
 
class Clock {
  float s, m, h;
  Clock(){
  }
 
  void getTime(){
    s = second();
    m = minute() + (s/60.0);
    h = hour()%12 + (m/60.0);
  }
 
  void draw(){
    translate(clockWidth/2, clockHeight/2);
    rotate(radians(180));
    pushMatrix();
    fill(128);
    noStroke();
    
    //int lt = 0;
    
    for(int i = 0; i<60; i++){
      rotate(radians(6));
      ellipse(clockWidth/2-MARGIN,0,3,3);
    }
    for(int i = 0; i<12; i++){
      rotate(radians(30));
      ellipse(clockWidth/2-MARGIN,0,10,10);
    }
    popMatrix();
    noFill();
    stroke(255);
    pushMatrix();
    rotate(radians(s*(360/60)));
    strokeWeight(1);
    //line(0,0,0,clockWidth/2-MARGIN);
    line(0,0,0,clockWidth);
    popMatrix();
    pushMatrix();
    rotate(radians(m*(360/60)));
    strokeWeight(2);
    line(0,0,0,clockWidth/2-MARGIN);
    popMatrix();
    pushMatrix();
    rotate(radians(h*(360/12)));
    strokeWeight(4);
    line(0,0,0,clockWidth/2.5-MARGIN);
    popMatrix();
  }
}