import java.util.*;
import processing.serial.*;
import spout.*;

// 葉っぱの生存時間
static final int LIFESPAN = 2550;

// インタラクションで追加される葉っぱの数
static final int NUM_LEAVES = 100;

// 葉っぱが自動的に増えるフレーム間隔  小さいほど頻繁に増える
static final int INTERVAL_LEAVES = 10;

//
static final int PARTICLE_NUM = 5;

// Variables
boolean bSpout = true;
Spout   spout;
boolean bSerial = true;
Serial  serialPort;
int     serialVal;
PImage  bgImage;
PImage  treeLeft[];
PImage  treeRight[];

ArrayList<MomijiParticle> particles;
ArrayList<PImage> images;

Snowman snowman;
int blink;

//---------------------------------------
//  setup
//
void setup() {

  size(1024, 640, P3D);

  colorMode(HSB, 100, 100, 100, LIFESPAN);

  if (bSpout) {
    spout = new Spout(this);
    spout.createSender("Spout Processing");
  }

  if (bSerial) {
    println(Serial.list());
    String portName = Serial.list()[0];
    serialPort = new Serial(this, portName, 9600);
  }
  serialVal = 0;

  bgImage = loadImage("ground.png");
  treeLeft = new PImage[3];
  treeRight = new PImage[3];

  treeLeft[0] = loadImage("tree_left_0.png");
  treeRight[0] = loadImage("tree_right_0.png");
  treeLeft[1] = loadImage("tree_left_1.png");
  treeRight[1] = loadImage("tree_right_1.png");
  treeLeft[2] = loadImage("tree_left_2.png");
  treeRight[2] = loadImage("tree_right_2.png");

  particles = new ArrayList<MomijiParticle>();
  images = new ArrayList<PImage>();
  snowman = new Snowman();
  blink = 0;

  for (int i = 0; i < PARTICLE_NUM; i++ ) {
    PImage img = loadImage( "s" + i + ".png");
    images.add(img);
  }
}


//---------------------------------------
// draw
//
void draw() {

  colorMode(HSB, 10000, 100, 100);
  background(frameCount % 10000, 40, 80);
  imageMode(CORNER);
  image(bgImage, 0, height-bgImage.height);
  //image(treeLeft, 0,0);
  //image(treeRight, 555 ,0,640,640);
  colorMode(RGB, 100, 100, 100, LIFESPAN);


  // 葉っぱの自動追加
  if ( frameCount % INTERVAL_LEAVES == 0)
    particles.add(new MomijiParticle(new PVector(random(width), 0)));


  // Arduinoの値を読み込み
  if ( bSerial && serialPort.available() > 0 ) {
    serialVal = serialPort.read();
  } else {
    serialVal = 0;
  }
  println(frameCount + " : " + serialVal);

  if ( serialVal == 1) {
    addParticle();
  }

  // デバッグ
  if ( mousePressed )   serialVal = 1;

  if( serialVal == 2){
    snowman.nextState();
  }

  if( serialVal == 3){
    blink = 1;
  }

  // パーティクル更新
  Iterator<MomijiParticle> it = particles.iterator();
  while ( it.hasNext() ) {

    MomijiParticle p = it.next();
    p.update();
    //p.display();
    p.display( images.get(p.type) );
    //p.run();

    if ( p.isDead() ) {
      it.remove();
    }
  }

  imageMode(CORNER);

  int treeindex = 0;
  if( blink > 0 && 0 != (frameCount % 2) ){
    treeindex = blink % 3;
    blink++;
    if(blink >= 100){
      blink = 0;
    }
  }
  image(treeLeft[treeindex], 0, 0);
  image(treeRight[treeindex], width - treeRight[treeindex].width, 0);

  snowman.display();

  if (bSpout)
    spout.sendTexture();
}


//---------------------------------------
// Event
//
void mousePressed() {

  for (int i = 0; i < NUM_LEAVES; i++) {
    particles.add(new MomijiParticle(new PVector(mouseX, mouseY)));
  }
}

void keyPressed(){
  if(key == ' ')
    snowman.nextState();
  if(key == 't'){
    blink++;
  }
}

void addParticle() {
  int rx = (int)random(width);
  int ry = (int)random(height/2);
  for (int i = 0; i < NUM_LEAVES; i++) {
    particles.add(new MomijiParticle(new PVector(rx, ry)));
  }
}
