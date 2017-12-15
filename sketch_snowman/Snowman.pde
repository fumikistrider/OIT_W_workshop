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
    state = 0;
  }


}
