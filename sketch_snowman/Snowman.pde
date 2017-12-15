class Snowman{

  PImage[] imgs;
  int state;
  int[] tintVal;

  Snowman(){
    imgs = new PImage[5];
    tintVal = new int[5];
    for(int i = 0; i < 5; i++){
      imgs[i] = loadImage("snowman_" + i + ".png");
      tintVal[i] = 0;
    }
    state = -1;
  }

  void nextState(){
    if( state == -1){
      state = 0;
    }
    else if(state == 0){
      state = 1;
    }
    else if(state == 1){
      state += (1 + (int)random(3) );
    }else{
      state = -1;
    }
    println("Snowman state :" + state);
  }

  void display(){

    for(int i = 0; i < 5; i++){
      tint(255,255,255,tintVal[i]);
      image(imgs[i], 100,300);
    }

    if( state >= 0 && state <= 4){
      tintVal[state] += 10;
    }else{
      for(int i = 0; i < 5; i++){
        if(tintVal[i] > 0) tintVal[i] -= 20;
      }
    }
    noTint();
  }

}
