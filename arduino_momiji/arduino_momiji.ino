int lastVal = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

  pinMode(2, INPUT);
  pinMode(4, INPUT);
  pinMode(6, INPUT);
  pinMode(13, OUTPUT);

}

void loop() {

  int val2 = digitalRead(2);
  int val4 = digitalRead(4);
  int val6 = digitalRead(6);
  delay(1);

    if( val6 == 1 ){
      Serial.write(1);
      delay(1000);
    }else{
      Serial.write(0);
    }

/*
  if( lastVal == 0 ){

    if( val6 == 1 ){
      Serial.println("BANG");
      lastVal = 1;
    }else{
      Serial.println(0);
    }
      delay(1);
  }else{
    if( val6 == 0 ){
      lastVal = 0;
    }
  }
*/
  digitalWrite(13,HIGH);
  delay(100);
    
}

