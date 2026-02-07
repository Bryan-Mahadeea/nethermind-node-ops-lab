# Support cheatsheet (Week 1)

This is a practical checklist I can use during support. The goal is to collect the minimum correct info fast, confirm facts with data, and avoid guessing.

---

## Case 1: “My transaction is stuck”
### First, clarify what “stuck” means
Ask:
- What is the transaction hash?
- Which network are you on (Ethereum mainnet, Sepolia, etc.)?
- Where are you checking it (which explorer or app)?

### Quick checks (facts)
Check:
- Is the transaction included in a block yet?
  - If yes: it is not stuck, it is confirmed or failed. Next step: check receipt status and gas used.
  - If no: it is pending in the mempool.

### If pending (not in a block)
Ask:
- When was it sent (approx time and timezone)?
- What fee settings were used (gas price / max fee / priority fee)?
- Did the user send multiple transactions quickly from the same wallet?

Common causes:
- Fees too low for current network conditions
- Account nonce issue (a previous transaction is pending and blocks the next one)

What to do next:
- Confirm whether the wallet supports speed up / replace-by-fee and explain it briefly
- If the user cannot speed up: explain they may need to wait or re-submit with higher fees depending on wallet features

---

## Case 2: “My node is not syncing”
### First questions
Ask:
- Which client are you running (Nethermind version)?
- Which network (mainnet, testnet)?
- Is this a fresh sync or was it synced before?
- What is your hardware (disk type/size, RAM, CPU) and available disk space?
- Are you running in Docker or native?

### Quick checks (facts)
Check:
- Current block number (local node)
- Sync status (is it actively syncing or stuck)
- Peer count (are there peers connected)
- Recent logs (errors/warnings around sync)

Common causes
- Not enough disk space or slow disk (IO bottleneck)
- Weak or unstable internet connection
- Wrong configuration for the intended network
- Too few peers or networking/firewall issues
- Starting from scratch without enough resources (will take a long time)

What to do next
- Confirm disk space and disk type (SSD strongly preferred for serious sync)
- Confirm peers are connected and ports/firewall are not blocking
- Share the exact log lines around the problem time
- If it is just slow, set expectations and track progress by block height over time

---

## Case 3: “Logs are missing” (events not showing)
### First questions
Ask:
- Which network and which RPC endpoint are you using?
- What is the contract address?
- What event are you expecting (name or signature if possible)?
- What transaction hash or block range are you checking?
- What tool are you using (explorer, your backend, a script)?

### Quick checks (facts)
Check:
- Does the transaction exist on that network?
- Does the transaction receipt contain logs?
  - If receipt has zero logs: the contract did not emit an event in that execution, or it reverted before emitting.
- If using `eth_getLogs`: is the filter correct?

Common causes
- Wrong network
- Wrong contract address
- Wrong block range
- Topic filter mismatch
- The event parameter was not indexed, so it cannot be filtered as a topic
- The transaction reverted, so expected events never happened

What to do next
- Ask for the exact transaction hash and inspect the receipt logs
- If using `eth_getLogs`, reduce the block range and simplify filters to isolate the issue
- Confirm the event signature and which parameters are indexed
