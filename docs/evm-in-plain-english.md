# EVM in plain English

## What happens when a transaction is sent
A transaction starts as a signed message created by a wallet. The user signs it with their private key, which proves the transaction is authorized by that account. The wallet sends the transaction to an Ethereum node, and that node shares it with other nodes, so it spreads across the network.

At first, the transaction is not in a block. It sits in a waiting area that nodes keep, often called the mempool. A transaction becomes “real” on chain when a block producer includes it in a block. Once included, execution happens: the execution client runs the transaction through the EVM, applying the rules of Ethereum. If it succeeds, it updates balances and contract storage. If it fails (reverts), most state changes are undone, but the transaction still exists in history and still consumes gas for the work that was attempted.

## Why receipts and logs exist
A receipt exists because you need a standardized result record after execution. When a transaction is executed, users and apps need to know if it succeeded, how much gas it used, and what it produced. The receipt is that proof. It lets tools and support people answer questions like: did it revert, how much gas was consumed, which block included it, and what side outputs were created.

Logs exist because smart contract activity often needs to be observed by systems outside the chain. Many applications do not want to constantly read contract state after every block. Instead, contracts emit logs (often through events) during execution, and those logs are stored with the transaction receipt. Logs are designed to be searchable, so indexers, explorers, analytics tools, and backends can efficiently detect “what happened” and react to it.

## Why logs are different from state
State is the current snapshot of Ethereum: balances, contract code, and contract storage values. It represents “how things are now.” Logs are not part of that snapshot. Logs are historical records attached to transactions, describing that something happened during execution.

A simple way to remember the difference is: state answers “what is true right now,” while logs answer “what happened during this transaction.” You can update state without emitting logs, and you can emit logs while state changes are limited or later overwritten by other transactions. Logs are mainly for off-chain consumption and filtering, while state is what the EVM reads and writes to enforce the rules of the system.
