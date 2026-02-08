# Daily log

## 2026-02-05
- Week 0 setup started
- Installed Git and VS Code
- Created GitHub repo and cloned locally
- Created folder structure: docs, scripts, monitoring, ops
- Created starter markdown files
## 2026-02-05
- Week 1 Day 1
- Wrote initial explanation: blockchain, node, execution client
## 2026-02-06
- Week 1 Day 2
- Read Ethereum whitepaper (light pass)
- Added glossary definitions: account, transaction, gas, block, state, smart contract
- Learned EVM basics (beginner level)
- Added glossary definitions: EVM, opcode, receipt, log, event, topic
## 2026-02-07
- Week 1 Day 3
- Read early conceptual parts of Mastering Ethereum (transactions, EVM execution, receipts, logs)
- Wrote docs/evm-in-plain-english.md (transaction lifecycle, receipts/logs, logs vs state)
- Wrote docs/support-cheatsheet.md (tx stuck, node not syncing, logs missing)
## 2026-02-08
- Week 1 Day 4
- Objective: Install Nethermind via winget, locate the executable path, run mainnet for a few minutes, capture proof logs.
- OS: Windows
- Data dir: C:\Nethermind\data
- Logs dir: C:\Nethermind\logs

### Commands I ran (exact)
- winget install --id Nethermind.Nethermind
winget list --id Nethermind.Nethermind

$root = Join-Path $env:LOCALAPPDATA "Microsoft\WinGet\Packages"
$root
Get-ChildItem $root -Recurse -ErrorAction SilentlyContinue |cd /c/Projects/nethermind-node-ops-lab


  Where-Object { $_.Name -ieq "nethermind.exe" } |
  Select-Object -First 10 FullName

- & $nm -c mainnet --data-dir "C:\Nethermind\data" *>> "C:\Nethermind\logs\nethermind-week2-day1.log"

Get-Content "C:\Nethermind\logs\nethermind-week2-day1.log" -Tail 80




### Proof output (short)
- Command line alias added: "nethermind"
Successfully installed

Nethermind Nethermind.Nethermind 1.36.0  winget

C:\Users\Bryan\AppData\Local\Microsoft\WinGet\Packages\Nethermind.Nethermind_Microsoft.Winget.Source_8wekyb3d8bbwe\nethermind.exe


----------------------------- Initialization Completed -----------------------------

Public id : Nethermind/v1.36.0+31cb81b7/windows-x64/dotnet10.0.1

Chain ID : Mainnet

Chainspec : chainspec/foundation.json

Genesis hash : 0xd4e56740f876aef8c010b86a40d5f56745a118d0906a34e69aec8c0db1cb8fa3

Chain head : 0

JSON RPC : http://127.0.0.1:8545 ; http://localhost:8551

RPC modules : Eth, Health, Net, Parity, Personal, Proof, Rpc, Subscribe, Trace, TxPool, Web3

Waiting for Forkchoice message from Consensus Layer to set fresh pivot block [0s]

Waiting for Forkchoice message from Consensus Layer to set fresh pivot block [10s]

Waiting for Forkchoice message from Consensus Layer to set fresh pivot block [20s]

The authentication secret hasn't been found in 'C:\Nethermind\data\keystore\jwt-secret' so it has been automatically created.

Connected to 3 bootnodes, 3 trusted/persisted nodes

Peers: 1 | with best block: 1 | eth69 (100 %) | Active: None | Sleeping: All

Why: shows networking is active.
### Files created
- C:\Nethermind
- C:\Nethermind\data
- C:\Nethermind\logs
- C:\Nethermind\logs\nethermind-week2-day1.log

### Issues
- (If anything fails, I paste the exact error text here)

