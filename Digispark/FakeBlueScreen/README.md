# Digispark BadUSB FakeBlueScreen

## Board: Digispark ATTiny85

## Triggers realistic fake BSOD pages in browser:
- Auto-runs on insertion
- Forces fullscreen mode
- Provides LED operation feedback
- Minimal command prompt visibility

## Usage:
1. Install Arduino IDE
2. Add Digispark support:
   - File > Preferences > Additional Boards Manager URLs:
     http://digistump.com/package_digistump_index.json
3. Install Digistump AVR package
4. Select board: Digispark (Default 16.5mhz)
5. Paste this code
6. Click Upload
7. When prompted, plug in Digispark

---

## For different alert page, you can use this links : 
1. https://www.ravbug.com/bsod/bsod10?g
2. https://www.ravbug.com/bsod/bsod10
3. https://www.ravbug.com/bsod/bsod8
4. https://www.ravbug.com/bsod/booterror7
5. https://www.ravbug.com/bsod/bsod7

---

## OPERATION
1. Plug into target PC
2. Script auto-executes:
   - Opens browser to BSOD page
   - Activates fullscreen
3. LED blinks when complete