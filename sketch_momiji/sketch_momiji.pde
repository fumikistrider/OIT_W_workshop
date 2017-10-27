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

ArrayList<MomijiParticle> particles;
ArrayList<PImage> images;


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
    //String portName = Serial.list()[1];
    //serialPort = new Serial(this, portName, 9600);
  }
  serialVal = 0;

  bgImage = loadImage("back.png");

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