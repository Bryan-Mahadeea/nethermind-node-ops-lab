# Daily log

## 2026-02-05

* Week 0 setup started
* Installed Git and VS Code
* Created GitHub repo and cloned locally
* Created folder structure: docs, scripts, monitoring, ops
* Created starter markdown files

## 2026-02-05

* Week 1 Day 1
* Wrote initial explanation: blockchain, node, execution client

## 2026-02-06

* Week 1 Day 2
* Read Ethereum whitepaper (light pass)
* Added glossary definitions: account, transaction, gas, block, state, smart contract
* Learned EVM basics (beginner level)
* Added glossary definitions: EVM, opcode, receipt, log, event, topic

## 2026-02-07

* Week 1 Day 3
* Read early conceptual parts of Mastering Ethereum (transactions, EVM execution, receipts, logs)
* Wrote docs/evm-in-plain-english.md (transaction lifecycle, receipts/logs, logs vs state)
* Wrote docs/support-cheatsheet.md (tx stuck, node not syncing, logs missing)

## 2026-02-08

* Week 1 Day 4
* Objective: Install Nethermind via winget, locate the executable path, run mainnet for a few minutes, capture proof logs.
* OS: Windows
* Data dir: C:\\Nethermind\\data
* Logs dir: C:\\Nethermind\\logs

### Commands I ran (exact)

* winget install --id Nethermind.Nethermind
  winget list --id Nethermind.Nethermind

$root = Join-Path $env:LOCALAPPDATA "Microsoft\\WinGet\\Packages"
$root
Get-ChildItem $root -Recurse -ErrorAction SilentlyContinue |cd /c/Projects/nethermind-node-ops-lab



Where-Object { $\_.Name -ieq "nethermind.exe" } |
Select-Object -First 10 FullName

* \& $nm -c mainnet --data-dir "C:\\Nethermind\\data" \*>> "C:\\Nethermind\\logs\\nethermind-week2-day1.log"

Get-Content "C:\\Nethermind\\logs\\nethermind-week2-day1.log" -Tail 80





### Proof output (short)

* Command line alias added: "nethermind"
  Successfully installed

Nethermind Nethermind.Nethermind 1.36.0  winget

C:\\Users\\Bryan\\AppData\\Local\\Microsoft\\WinGet\\Packages\\Nethermind.Nethermind\_Microsoft.Winget.Source\_8wekyb3d8bbwe\\nethermind.exe



----------------------------- Initialization Completed -----------------------------

Public id : Nethermind/v1.36.0+31cb81b7/windows-x64/dotnet10.0.1

Chain ID : Mainnet

Chainspec : chainspec/foundation.json

Genesis hash : 0xd4e56740f876aef8c010b86a40d5f56745a118d0906a34e69aec8c0db1cb8fa3

Chain head : 0

JSON RPC : http://127.0.0.1:8545 ; http://localhost:8551

RPC modules : Eth, Health, Net, Parity, Personal, Proof, Rpc, Subscribe, Trace, TxPool, Web3

Waiting for Forkchoice message from Consensus Layer to set fresh pivot block \[0s]

Waiting for Forkchoice message from Consensus Layer to set fresh pivot block \[10s]

Waiting for Forkchoice message from Consensus Layer to set fresh pivot block \[20s]

The authentication secret hasn't been found in 'C:\\Nethermind\\data\\keystore\\jwt-secret' so it has been automatically created.

Connected to 3 bootnodes, 3 trusted/persisted nodes

Peers: 1 | with best block: 1 | eth69 (100 %) | Active: None | Sleeping: All

Why: shows networking is active.

### Files created

* C:\\Nethermind
* C:\\Nethermind\\data
* C:\\Nethermind\\logs
* C:\\Nethermind\\logs\\nethermind-week2-day1.log

### Issues

* (If anything fails, I paste the exact error text here)

## 2026-02-09

* Week 1 Day 5: Connected consensus client (Teku) to execution client (Nethermind) for Ethereum mainnet post-merge sync.

What I installed / used:

* Execution client: Nethermind v1.36.0+31cb81b7 (installed via WinGet package path)
* Consensus client: Teku v25.12.0 (C:\\Teku\\teku-25.12.0)

Key paths:

* Nethermind exe:
  C:\\Users\\Bryan\\AppData\\Local\\Microsoft\\WinGet\\Packages\\Nethermind.Nethermind\_Microsoft.Winget.Source\_8wekyb3d8bbwe\\nethermind.exe
* Nethermind data dir:
  C:\\Nethermind\\data
* Nethermind logs:
  C:\\Nethermind\\data\\logs
* JWT secret file used for Engine API auth (path only):
  C:\\Nethermind\\data\\keystore\\jwt-secret
* Teku binary:
  C:\\Teku\\teku-25.12.0\\bin\\teku.bat
* Teku data dir:
  C:\\Teku\\data

Commands run:

* Start Nethermind (execution client):
  $nm = "C:\\Users\\Bryan\\AppData\\Local\\Microsoft\\WinGet\\Packages\\Nethermind.Nethermind\_Microsoft.Winget.Source\_8wekyb3d8bbwe\\nethermind.exe"
  \& $nm -c mainnet --data-dir "C:\\Nethermind\\data"
* Teku attempt without checkpoint sync (failed due to weak subjectivity):
  \& "C:\\Teku\\teku-25.12.0\\bin\\teku.bat" --network=mainnet --data-path="C:\\Teku\\data" --ee-endpoint="http://localhost:8551" --ee-jwt-secret-file="C:\\Nethermind\\data\\keystore\\jwt-secret"
* Teku with checkpoint sync (success):
  \& "C:\\Teku\\teku-25.12.0\\bin\\teku.bat" --network=mainnet --data-path="C:\\Teku\\data" --ee-endpoint="http://localhost:8551" --ee-jwt-secret-file="C:\\Nethermind\\data\\keystore\\jwt-secret" --checkpoint-sync-url="https://beaconstate.info"

Proof that EL and CL are connected:

* Teku:

  * Execution Client is online
  * Syncing started
  * Execution Client version: Nethermind 1.36.0+31cb81b7

* Nethermind:

  * Waiting for Forkchoice message from Consensus Layer...
  * Then started receiving ForkChoice updates, set a new pivot block, and began syncing headers/blocks.

    Date: 2026-02-10

  * 
  * Week 1 Day 6: Enabled Teku REST API and verified endpoints
  * 
  * Verified:
  * 
  * GET /eth/v1/node/version returned Teku version JSON
  * 
  * GET /eth/v1/node/health returned HTTP 206
  * 
  * Key ports:
  * 
  * Teku REST: 127.0.0.1:5051
  * 
  * Nethermind JSON-RPC: 127.0.0.1:8545
  * 
  * Nethermind Engine API: 127.0.0.1:8551 (JWT protected)
  * 

     Create a node health check script (PowerShell)

    

    Goal:

    \* Create scripts/node\_health\_check.ps1 that prints:

      \* timestamp

      \* current execution layer block number (via Nethermind JSON-RPC)

      \* syncing status (via eth\_syncing)

      \* consensus layer health (via Teku REST)

    

    What this script checks:

    

    1\) Nethermind JSON-RPC (Execution Layer)

    \* URL: http://127.0.0.1:8545

    \* Calls:

      \* eth\_blockNumber  -> returns current block number (hex)

      \* eth\_syncing      -> returns false (not syncing) OR an object (syncing)

    

    2\) Teku REST API (Consensus Layer)

    \* URL: http://127.0.0.1:5051/eth/v1/node/health

    \* Note: Teku REST must be enabled when starting Teku or this will fail.

    

    How to run:

    \* From repo root:

      powershell -ExecutionPolicy Bypass -File .\\scripts\\node\_health\_check.ps1

    

    Important:

    \* If Nethermind or Teku are not running, this script will show FAIL/WARN. That is expected.

    \* For the checks to pass:

      \* Nethermind must be running with JSON-RPC available on 8545

      \* Teku must be running with REST enabled on 5051

    

    Files created/updated:

    \* scripts/node\_health\_check.ps1

    \* ops/daily-log.md

    Week 1 Day 7

    

    Added log output to: ops\\logs\\node-health.log

    

    Script updated: scripts\\node\_health\_check.ps1 (LogFile + Write-Out)

    

    Scheduled task: NethermindNodeHealthCheck every 15 minutes

    

    Manual trigger: schtasks /Run /TN "NethermindNodeHealthCheck"

