class MomijiParticle extends Particle{
  
  int type;
  int rotate;
  boolean isClock;
  
  MomijiParticle(PVector l) {
    super(l);
    type = (int)random(0,PARTICLE_NUM);
    //type = (int)random(0,6);
    rotate = (int)random(360);
    if( random(1) < 0.5 ) {
      isClock = true;
    }else{
      isClock = false;
    }
  }
  
  void display(PImage img) {
    stroke(100,100,100,lifespan);
    fill(100,100,100,lifespan);
    tint(100,100,100,lifespan);
    imageMode(CENTER);

    pushMatrix();
    translate(location.x, location.y);
    rotate(radians(rotate));
    image(img,0,0);
    popMatrix();
    
    if( location.y <= height - 60 ){
      if( isClock ){
        rotate++;
      }else{
        rotate--;
      }
    }
}


}