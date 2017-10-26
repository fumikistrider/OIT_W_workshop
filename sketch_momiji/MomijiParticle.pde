class MomijiParticle extends Particle{
  
  int type;
  
  MomijiParticle(PVector l) {
    super(l);
    type = (int)random(0,8);
  }
  
  void display(PImage img) {
    stroke(100,100,100,lifespan);
    fill(100,100,100,lifespan);
    tint(100,100,100,lifespan);
    imageMode(CENTER);
    image(img,location.x,location.y);
  }


}