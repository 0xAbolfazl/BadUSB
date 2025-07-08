# Digispark BadUSB Auto-Downloader

## Description
This Digispark script automatically downloads and installs an executable file to the Windows Startup folder for persistent execution. Designed for authorized penetration testing and educational purposes only.

## Features
- Downloads EXE from specified URL
- Installs to Windows Startup folder (%appdata%\Microsoft\Windows\Start Menu\Programs\Startup)
- Executes payload immediately
- Provides LED status indication

## Requirements
- Digispark ATTiny85 board
- Arduino IDE with Digistump packages
- Target Windows machine (7/10/11)

## Setup Instructions
1. Replace placeholders in the script:
   - `DOWNLOAD_URL` - Your executable's download URL
   - `TARGET_PATH` - Desired filename in Startup folder

2. Upload to Digispark:
   - Install Arduino IDE
   - Add Digistump boards package
   - Select Digispark (Default 16.5mhz)
   - Upload script

## Usage
1. Insert Digispark into target machine
2. Script will automatically:
   - Open hidden command prompt
   - Download your EXE
   - Install to Startup folder
   - Execute payload
3. Blue LED blinks on completion

## Security Notes
- Use only with explicit permission
- Recommended to use HTTPS URLs
- EXE will run on every system startup
- For testing, use non-malicious payloads first

## Legal Warning
Unauthorized use of this tool on systems you don't own is illegal. Use only for legitimate security testing with proper permissions.

## Troubleshooting
- Increase delays if script fails
- Check URL accessibility from target network
- Verify Digispark drivers are installed