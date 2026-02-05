# What is an Ethereum node?

# What is an Ethereum node?

## What a blockchain is
A blockchain is a shared database that many computers keep in sync. Instead of one central server deciding what is true, multiple independent computers store the same history and agree on the current state based on agreed rules.

On Ethereum, the blockchain includes a sequence of blocks that contain transactions. Those transactions change the system state, like account balances and smart contract storage, in a way that anyone can verify.

## What a node is
A node is a computer running software that participates in the network by downloading and verifying blockchain data. A node checks the rules for blocks and transactions, so it does not need to trust any single website or provider.

A node can also serve data to other apps and users. For example, wallets, explorers, or backend services can ask a node questions like the latest block number, a transaction receipt, or logs for an event.

## What an execution client is
An execution client is the part of an Ethereum node that executes transactions and maintains the state, including smart contract execution. It exposes JSON-RPC methods like `eth_blockNumber` and `eth_getLogs` so apps can interact with the chain through standard requests.

