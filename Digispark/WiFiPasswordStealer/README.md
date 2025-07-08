Digispark BadUSB WiFi Credential Extractor

Board: Digispark ATTiny85

Function:
- Extracts saved WiFi passwords from Windows machines
- Sends credentials to specified webhook URL
- Operates stealthily with minimal cmd window
- Self-cleaning (deletes temp files)
- Provides LED status indication

Usage:
1. Install Arduino IDE
2. Add Digispark support:
   - File > Preferences > Additional Boards Manager URLs:
     http://digistump.com/package_digistump_index.json
3. Install Digistump AVR package
4. Select board: Digispark (Default 16.5mhz)
5. Paste this code
6. Click Upload
7. When prompted, plug in Digispark

Operation:
1. Insert into target PC
2. Script auto-runs
3. LED blinks on completion

Webhook Setup:
Replace WEBHOOK_URL with your endpoint

Note: For educational purposes only. Use only on systems you own or have permission to test.