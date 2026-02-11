param(
  [string]$NethermindRpc = "http://127.0.0.1:8545"
)

function Write-Section($title) {
  Write-Host ""
  Write-Host "=== $title ==="
}

function Invoke-JsonRpc($Url, $Method, $Params = @()) {
  $payload = @{
    jsonrpc = "2.0"
    id      = 1
    method  = $Method
    params  = $Params
  } | ConvertTo-Json -Compress

  try {
    return Invoke-RestMethod -Uri $Url -Method Post -ContentType "application/json" -Body $payload -TimeoutSec 10
  } catch {
    throw $_
  }
}

$ts = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== Node Health Check ==="
Write-Host "Time: $ts"
Write-Host ""

Write-Section "Nethermind JSON-RPC"
Write-Host "Target: $NethermindRpc"

try {
  $bn = Invoke-JsonRpc -Url $NethermindRpc -Method "eth_blockNumber"
  $sync = Invoke-JsonRpc -Url $NethermindRpc -Method "eth_syncing"

  if ($null -eq $bn.result) {
    Write-Host "FAIL: eth_blockNumber returned no result"
  } else {
    $blockDec = [Convert]::ToInt64($bn.result, 16)
    Write-Host "OK: blockNumber = $blockDec"
  }

  if ($null -eq $sync.result) {
    Write-Host "FAIL: eth_syncing returned no result"
  } elseif ($sync.result -eq $false) {
    Write-Host "OK: syncing = false (fully synced or not currently syncing)"
  } else {
    Write-Host "WARN: syncing = true (node is syncing)"
    if ($sync.result.currentBlock) {
      $cur = [Convert]::ToInt64($sync.result.currentBlock, 16)
      Write-Host "  currentBlock = $cur"
    }
    if ($sync.result.highestBlock) {
      $hi = [Convert]::ToInt64($sync.result.highestBlock, 16)
      Write-Host "  highestBlock = $hi"
    }
  }
}
catch {
  Write-Host "FAIL: JSON-RPC check failed"
  Write-Host "Error: $($_.Exception.Message)"
}

Write-Host ""
Write-Host "=== Done ==="
