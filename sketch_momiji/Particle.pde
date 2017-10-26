
class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector(0,0.01);
    velocity = new PVector(random(-1,1),random(-0.5,0));
    location = l.get();
    lifespan = LIFESPAN;
  }

  void run() {
    update();
    display();
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    
    if(location.y > height - 50){ location.y = height - 50; velocity.x = 0; }
    
    if( mousePressed && location.y > (height /2)){
      velocity = new PVector( random(-2,2),random(-5.0,0) );
    }
    
    lifespan -= 2.0;
  }

  void display() {
    stroke(0,lifespan);
    fill(0,lifespan);
    ellipse(location.x,location.y,8,8);
  }

  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}