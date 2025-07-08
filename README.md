# BadUSB Toolkit - Digispark & Arduino Pro Micro Edition

## Project Description
This repository contains a collection of BadUSB scripts for Digispark ATTiny85 and Arduino Pro Micro boards. These scripts are intended for legitimate penetration testing, security research, and educational purposes only.

## Repository Structure
```
repo/
└── digispark/
├── wifi_password_stealer.ino # Extracts and exfiltrates WiFi credentials
└── auto_downloader.ino # Downloads and persists payloads
```


## Digispark Scripts

### 1. WiFi Password Stealer (wifi_password_stealer.ino)
- Extracts saved WiFi profiles with clear-text passwords
- Exports credentials to XML files
- Can send data to webhook/server (configure URL)
- Self-cleaning (removes temp files)
- LED status indication

### 2. Auto Downloader (auto_downloader.ino)
- Downloads executable from specified URL
- Installs to Windows Startup folder for persistence
- Immediate execution capability
- Hidden command prompt operation
- Visual completion indicator

## Usage Guidelines (Digispark)

1. Requirements:
   - Digispark ATTiny85 board
   - Arduino IDE with Digistump packages
   - Micro-USB cable

2. Configuration:
   - Set your target URLs/webhooks in each script
   - Adjust delays if needed for different systems

3. Upload Process:
   - Select correct board (Digispark 16.5mhz)
   - Upload while Digispark is unplugged
   - Insert Digispark when prompted

## Legal Disclaimer
All scripts are provided for:
- Authorized security testing
- Educational demonstrations
- Defensive research

Unauthorized use against systems you don't own is illegal. Always obtain proper permissions before testing.

## Contribution
New script ideas are welcome. Please:
1. Maintain clean, commented code
2. Include basic documentation
3. Test thoroughly before submitting PR

## Support
For issues/questions:
- Check Arduino error messages
- Verify Digispark drivers are installed
- Test with non-malicious payloads first