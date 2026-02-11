param(
  [string]$NethermindRpc = "http://127.0.0.1:8545",
  [string]$TekuRestBase  = "http://127.0.0.1:5051",
  [int]$TimeoutSec = 4,
  [string]$LogFile = ".\ops\logs\node-health.log",
  [switch]$NoLog
)

# Ensure log directory exists
try {
  $logDir = Split-Path -Parent $LogFile
  if ($logDir -and -not (Test-Path $logDir)) {
    New-Item -ItemType Directory -Force -Path $logDir | Out-Null
  }
} catch {}

function Write-Out($msg) {
  Write-Host $msg
  if (-not $NoLog) {
    try { Add-Content -Path $LogFile -Value $msg } catch {}
  }
}

function Is-Port-Open($ComputerName, $Port) {
  try {
    $result = Test-NetConnection -ComputerName $ComputerName -Port $Port -WarningAction SilentlyContinue
    return [bool]$result.TcpTestSucceeded
  } catch {
    return $false
  }
}

function JsonRpc($url, $method, $params) {
  $body = @{
    jsonrpc = "2.0"
    id      = 1
    method  = $method
    params  = $params
  } | ConvertTo-Json -Depth 6

  return Invoke-RestMethod -Uri $url -Method Post -ContentType "application/json" -Body $body -TimeoutSec $TimeoutSec
}

function HexToInt64($hex) {
  if (-not $hex) { return $null }
  $h = $hex.ToString().Replace("0x","")
  if ($h.Length -eq 0) { return 0 }
  return [Convert]::ToInt64($h,16)
}

$ts = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Out "=== Node Health Check ==="
Write-Out "Time: $ts"
Write-Out ""

# -----------------------
# Nethermind checks
# -----------------------
Write-Out "=== Nethermind JSON-RPC ==="
Write-Out "Target: $NethermindRpc"

$nmHost = "127.0.0.1"
$nmRpcPort = 8545

$rpcOpen = Is-Port-Open -ComputerName $nmHost -Port $nmRpcPort
if (-not $rpcOpen) {
  Write-Out "FAIL: JSON-RPC port $nmRpcPort is not reachable"
} else {
  try {
    $bn = JsonRpc $NethermindRpc "eth_blockNumber" @()
    $block = HexToInt64 $bn.result
    Write-Out "PASS: eth_blockNumber = $block"

    $sync = JsonRpc $NethermindRpc "eth_syncing" @()
    if ($sync.result -eq $false) {
      Write-Out "PASS: eth_syncing = false (not syncing)"
    } else {
      Write-Out "WARN: eth_syncing returned an object (still syncing)"
    }
  } catch {
    Write-Out "FAIL: JSON-RPC calls failed"
    Write-Out "Error: $($_.Exception.Message)"
  }
}

Write-Out ""

# -----------------------
# Teku checks
# -----------------------
Write-Out "=== Teku REST ==="
Write-Out "Target: $TekuRestBase/eth/v1/node/health"

$tekuHost = "127.0.0.1"
$tekuPort = 5051
$tekuOpen = Is-Port-Open -ComputerName $tekuHost -Port $tekuPort

if (-not $tekuOpen) {
  Write-Out "WARN: REST port $tekuPort is not reachable (expected if Teku REST is not enabled)"
} else {
  try {
    $healthUrl = "$TekuRestBase/eth/v1/node/health"
    $resp = Invoke-WebRequest -Uri $healthUrl -Method Get -TimeoutSec $TimeoutSec
    Write-Out "PASS: /eth/v1/node/health reachable (HTTP $($resp.StatusCode))"
  } catch {
    Write-Out "WARN: /eth/v1/node/health request failed"
    Write-Out "Error: $($_.Exception.Message)"
  }

  try {
    $ver = Invoke-RestMethod -Uri "$TekuRestBase/eth/v1/node/version" -Method Get -TimeoutSec $TimeoutSec
    Write-Out "PASS: version = $($ver.data.version)"
  } catch {
    Write-Out "WARN: cannot read /eth/v1/node/version"
    Write-Out "Error: $($_.Exception.Message)"
  }
}

Write-Out ""
Write-Out "=== Done ==="

