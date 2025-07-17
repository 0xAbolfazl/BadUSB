#include "Keyboard.h"

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  delay(1000); 
  

  Keyboard.press(KEY_LEFT_GUI);
  Keyboard.press('r');
  Keyboard.releaseAll();
  delay(500);
  

  Keyboard.print("cmd /c start https://www.ravbug.com/bsod/bsod10/");
  delay(500);
  Keyboard.press(KEY_RETURN);
  Keyboard.releaseAll();
  delay(2000);
  

  Keyboard.press(KEY_F11);
  Keyboard.releaseAll();
  delay(500);
}

void loop() {
  digitalWrite(LED_BUILTIN, HIGH)
  delay(100);
  digitalWrite(LED_BUILTIN, LOW); 
  delay(100);
}