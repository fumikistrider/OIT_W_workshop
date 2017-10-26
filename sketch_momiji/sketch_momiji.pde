import java.util.*;

import spout.*;

Spout spout;

PImage bgImage;

ArrayList<MomijiParticle> particles;
ArrayList<PImage> images;


// 葉っぱの生存時間
static final int LIFESPAN = 2550;

// インタラクションで追加される葉っぱの数
static final int NUM_LEAVES = 100;

// 葉っぱが自動的に増えるフレーム間隔  小さいほど頻繁に増える
static final int INTERVAL_LEAVES = 10;


void setup() {

  size(1024,640, P3D);
  
  colorMode(HSB,100,100,100, LIFESPAN);
  
  spout = new Spout(this);
  spout.createSender("Spout Processing");
  
  bgImage = loadImage("back.png");
  
  particles = new ArrayList<MomijiParticle>();
  images = new ArrayList<PImage>();

  for(int i = 0; i < 8; i++ ){
    PImage img = loadImage( i + ".png");
    images.add(img);    
  }

}

void draw() {
  
  colorMode(HSB,10000,100,100);
  background(frameCount % 10000, 40, 80);
  imageMode(CORNER);
  image(bgImage,0,0,1024,640);
  colorMode(RGB,100,100,100, LIFESPAN);
  

  if( frameCount % INTERVAL_LEAVES == 0)
    particles.add(new MomijiParticle(new PVector(random(width),0)));


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
  
  spout.sendTexture();
  
}


void mousePressed(){

  for(int i = 0; i < NUM_LEAVES; i++){
     particles.add(new MomijiParticle(new PVector(mouseX,mouseY)));
  }
    
}