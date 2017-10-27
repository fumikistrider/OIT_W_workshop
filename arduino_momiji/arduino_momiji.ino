int gpioVal = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

  pinMode(3, INPUT);

}

void loop() {
  // put your main code here, to run repeatedly:
  int receivedVal = digitalRead(3);

  if( receivedVal != gpioVal ){
    // 値が変化した
    if( receivedVal == 1 ){
      // GPIOタグがOFFからONになった時点で PCに 1 を送る
      Serial.write(1);      
    }else{
      // それ以外は 0 を送る
      Serial.write(0);
    }
    // 値を更新
    gpioVal = receivedVal;    
  }

}
