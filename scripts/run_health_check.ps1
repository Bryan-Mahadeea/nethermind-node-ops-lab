param(
  [string]$OutDir = ".\logs"
)

$tsFile = Get-Date -Format "yyyyMMdd-HHmmss"
$tsHuman = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

if (-not (Test-Path $OutDir)) {
  New-Item -ItemType Directory -Path $OutDir | Out-Null
}

$logFile = Join-Path $OutDir "node-health-$tsFile.log"

"=== Node Health Check Run ===" | Out-File -FilePath $logFile -Encoding utf8
"Time: $tsHuman" | Out-File -FilePath $logFile -Encoding utf8 -Append
"" | Out-File -FilePath $logFile -Encoding utf8 -Append

$scriptPath = Join-Path $PSScriptRoot "node_health_check.ps1"

if (-not (Test-Path $scriptPath)) {
  "FAIL: cannot find node_health_check.ps1 at $scriptPath" | Out-File -FilePath $logFile -Encoding utf8 -Append
  exit 1
}

# Run the health check and append output to the log
powershell -ExecutionPolicy Bypass -File $scriptPath *>> $logFile

# Also print where the log was written
Write-Host "Wrote log to: $logFile"
