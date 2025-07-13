#include "DigiKeyboard.h"

void setup() {
  pinMode(1, OUTPUT); // LED on Digispark is usually on pin 1
  DigiKeyboard.delay(1000);
  
  // Press Win + R
  DigiKeyboard.sendKeyStroke(KEY_R, MOD_GUI_LEFT);
  DigiKeyboard.delay(500);
  
  // Type the command (fixed the slash direction and space)
  DigiKeyboard.print("cmd /c start https://www.ravbug.com/bsod/bsod10/");
  DigiKeyboard.delay(500);
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(2000);
  
  // Go to full screen
  DigiKeyboard.sendKeyStroke(KEY_F11);
  DigiKeyboard.delay(500);
}

void loop() {
  digitalWrite(1, HIGH);   // Turn LED on
  DigiKeyboard.delay(100);
  digitalWrite(1, LOW);    // Turn LED off
  DigiKeyboard.delay(100);
}