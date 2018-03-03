import netP5.*;
import oscP5.*;

import spout.*;

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// An uneven surface

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.*;

Spout spout;

OscP5 oscP5;

// A reference to our box2d world
Box2DProcessing box2d;

// An ArrayList of particles that will fall on the surface
ArrayList<Particle> particles;

// An object to store information about the uneven surface
Surface surface;

PImage eggImage;

void setup() {
  size(768,1024,P3D);
  
  oscP5 = new OscP5(this,12345);

  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, -2);

  // Create the empty list
  particles = new ArrayList<Particle>();
  // Create the surface
  surface = new Surface();
  
  eggImage = loadImage("egg4.png");

  // CREATE A NEW SPOUT OBJECT
  spout = new Spout(this);
  spout.createSender("EggPhysics");
  
}

void draw() {
  
  // If the mouse is pressed, we make new particles
  if (mousePressed) {
    //float sz = random(2,6);
    float sz = random(10,30);
    particles.add(new Particle(mouseX,mouseY,sz));
  }
    
  // We must always step through time!
  box2d.step();

  background(0);

  // Draw the surface
  surface.display();

  // Draw all particles
  for (Particle p: particles) {
    p.display();
  }

  spout.sendTexture();

  // Particles that leave the screen, we delete them
  // (note they have to be deleted from both the box2d world and our list
  for (int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    if (p.done()) {
      particles.remove(i);
    }
  }
}


void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  
  if( theOscMessage.addrPattern().equals("/egg") ){
    int count = (int)random(1,second());
    for( int i = 0; i < count; i++) {
      float sz = random(10,30);
      particles.add(new Particle(random(width),50,sz));    
    }
  }
  else if( theOscMessage.addrPattern().equals("/destroy") ){
    surface.destroy();    
  }
  else if( theOscMessage.addrPattern().equals("/build") ){

    particles.clear();

    // Initialize box2d physics and create the world
    box2d = new Box2DProcessing(this);
    box2d.createWorld();
    // We are setting a custom gravity
    box2d.setGravity(0, -2);
    // Create the empty list
    particles = new ArrayList<Particle>();
    surface = new Surface();
  }
  
}

void keyPressed(){
  if(key == ' '){
    surface.destroy();    
  }
  
  if(key == 'b'){
    // Initialize box2d physics and create the world
    box2d = new Box2DProcessing(this);
    box2d.createWorld();
    // We are setting a custom gravity
    box2d.setGravity(0, -2);
    surface = new Surface();
  }
    
}