\# Week 1 Day 7 Proof: scheduled node health check + logs (Windows)



\## What this adds

\- scripts/run\_health\_check.ps1

&nbsp; - Runs scripts/node\_health\_check.ps1

&nbsp; - Writes output to logs/node-health-YYYYMMDD-HHMMSS.log

\- .gitignore updated so logs are never committed



\## How to run manually

From repo root:

powershell -ExecutionPolicy Bypass -File .\\scripts\\run\_health\_check.ps1



\## Where logs are written

Repo folder: logs\\

Example file: logs\\node-health-20260211-002944.log



\## How to verify output

Get newest log:

Get-Content (Get-ChildItem .\\logs\\\*.log | Sort-Object LastWriteTime -Descending | Select-Object -First 1).FullName -Tail 60



