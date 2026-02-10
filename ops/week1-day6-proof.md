# Week 1 Day 6 proof (Teku REST + verification)

## Goal
Enable Teku REST API and verify it responds locally.

## Commands and outputs

### 1) Teku version endpoint
Command:
curl.exe -s http://127.0.0.1:5051/eth/v1/node/version

Output:
{"data":{"version":"teku/v25.12.0/windows-x86_64/-eclipseadoptium-openjdk64bitservervm-java-21"}}

### 2) Teku health endpoint (with headers)
Command:
curl.exe -s -i http://127.0.0.1:5051/eth/v1/node/health

Output (headers):
HTTP/1.1 206 Partial Content
Content-Type: application/json
Server: Jetty(11.0.25)

Notes:
- 206 here indicates Teku is responding but not fully "ready" yet (typically still syncing).
