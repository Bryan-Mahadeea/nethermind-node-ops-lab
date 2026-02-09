# Week 1 Day 5 proof (2026-02-09)

## Goal
Run a post-merge Ethereum mainnet node by connecting:
- Execution client: Nethermind
- Consensus client: Teku
Using Engine API + JWT authentication.

## Components and versions
- Nethermind: v1.36.0+31cb81b7
- Teku: v25.12.0

## Paths
- Nethermind exe:
  C:\Users\Bryan\AppData\Local\Microsoft\WinGet\Packages\Nethermind.Nethermind_Microsoft.Winget.Source_8wekyb3d8bbwe\nethermind.exe
- Nethermind data dir:
  C:\Nethermind\data
- JWT secret file (path only):
  C:\Nethermind\data\keystore\jwt-secret
- Teku bat:
  C:\Teku\teku-25.12.0\bin\teku.bat
- Teku data dir:
  C:\Teku\data

## Commands used
Start Nethermind:
- $nm = "C:\Users\Bryan\AppData\Local\Microsoft\WinGet\Packages\Nethermind.Nethermind_Microsoft.Winget.Source_8wekyb3d8bbwe\nethermind.exe"
- & $nm -c mainnet --data-dir "C:\Nethermind\data"

Start Teku (checkpoint sync, mainnet):
- & "C:\Teku\teku-25.12.0\bin\teku.bat" --network=mainnet --data-path="C:\Teku\data" --ee-endpoint="http://localhost:8551" --ee-jwt-secret-file="C:\Nethermind\data\keystore\jwt-secret" --checkpoint-sync-url="https://beaconstate.info"

## Teku proof lines
- Loaded initial state from https://beaconstate.info/eth/v2/debug/beacon/states/finalized
- Loaded initial state at epoch 426579 ... block slot = 13650528
- Execution Client is online
- Syncing started
- Execution Client version: Nethermind 1.36.0+31cb81b7

## Nethermind proof lines
- Waiting for Forkchoice message from Consensus Layer...
- Received ForkChoice: ...
- New pivot block has been set based on ForkChoiceUpdate from CL. Pivot block number: 24418400 ...
- Changing sync ... to FastHeaders / FastSync
- Old Headers ... downloading/increasing
- Received New Block: 2441840X ...
