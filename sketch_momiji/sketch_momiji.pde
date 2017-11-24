import netP5.*;
import oscP5.*;

import java.util.*;
import processing.serial.*;
import spout.*;

// 葉っぱの生存時間
static final int LIFESPAN = 2550;

// インタラクションで追加される葉っぱの数
static final int NUM_LEAVES = 100;

// 葉っぱが自動的に増えるフレーム間隔  小さいほど頻繁に増える
static final int INTERVAL_LEAVES = 10;

// Variables
boolean bSpout = false;
Spout   spout;
boolean bSerial = false;
Serial  serialPort;
int     serialVal;
PImage  bgImage;
PImage  treeLeft;
PImage  treeRight;

ArrayList<MomijiParticle> particles;
ArrayList<PImage> images;

int intervalCount = 0;

OscP5 oscP5;
NetAddress myRemoteLocation;

//---------------------------------------
//  setup
//
void setup() {

  size(1024,640, P3D);

  colorMode(HSB,100,100,100, LIFESPAN);

  if(bSpout){
    spout = new Spout(this);
    spout.createSender("Spout Processing");
  }

  if(bSerial){
    println(Serial.list());
    String portName = Serial.list()[0];
    serialPort = new Serial(this, portName, 9600);
  }
  serialVal = 0;

  oscP5 = new OscP5(this,12340);
  myRemoteLocation = new NetAddress("127.0.0.1",12345);

  bgImage = loadImage("ground.png");
  treeLeft = loadImage("tree_left.png");
  treeRight = loadImage("tree_right.png");

  particles = new ArrayList<MomijiParticle>();
  images = new ArrayList<PImage>();

  for(int i = 0; i < 8; i++ ){
    PImage img = loadImage( i + ".png");
    images.add(img);
  }

}


//---------------------------------------
// draw
//
void draw() {

  colorMode(HSB,10000,100,100);
  background(frameCount % 10000, 40, 80);
  imageMode(CORNER);
  image(bgImage,0,0,1024,640);
  image(treeLeft, -120,0,640,640);
  image(treeRight, 555 ,0,640,640);
  colorMode(RGB,100,100,100, LIFESPAN);


  // 葉っぱの自動追加
  if( frameCount % INTERVAL_LEAVES == 0)
    particles.add(new MomijiParticle(new PVector(random(width),0)));


  // Arduinoの値を読み込み
  if( bSerial && serialPort.available() > 0 ){
    serialVal = serialPort.read();
  }else{
    serialVal = 0;
  }
  //println(frameCount + " : " + serialVal);

  if( serialVal == 1){
    addParticle();
  }

  // デバッグ
  if( mousePressed )   serialVal = 1;

  // パーティクル更新
  Iterator<MomijiParticle> it = particles.iterator();
  while( it.hasNext() ){

    MomijiParticle p = it.next();
    p.update();
    //p.display();
    p.display( images.get(p.type) );
    //p.run();

    if( p.isDead() ){
      it.remove();
    }

  }

  imageMode(CORNER);
  image(treeLeft, -120,0,640,640);
  image(treeRight, 555 ,0,640,640);

  if(bSpout)
    spout.sendTexture();

}


//---------------------------------------
// Event
//
void mousePressed(){

  for(int i = 0; i < NUM_LEAVES; i++){
     particles.add(new MomijiParticle(new PVector(mouseX,mouseY)));
  }

}

void addParticle(){
  int rx = (int)random(width);
  int ry = (int)random(height/2);
  for(int i = 0; i < NUM_LEAVES; i++){
     particles.add(new MomijiParticle(new PVector(rx,ry)));
  }
}