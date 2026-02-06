# Glossary

This glossary will grow as I learn.

## account
An account is an identity on Ethereum that can hold ETH and interact with the network. It can be a user wallet (controlled by a private key) or a smart contract account (controlled by code).

## transaction
A transaction is a signed message sent to the network that changes something, like sending ETH or calling a smart contract function. When included in a block, it can update balances or contract state.

## gas
Gas is the unit that measures how much computation or work a transaction uses. You pay for gas to prevent spam and to compensate the network for processing your transaction.

## block
A block is a bundle of transactions plus metadata, added to the blockchain in order. Blocks create a timeline of what happened and allow everyone to agree on the same history.

## state
State is the current snapshot of Ethereum, including account balances, contract code, and contract storage. Transactions move the state forward from one version to the next.

## smart contract
A smart contract is code deployed on Ethereum that runs when called by transactions. It can store data, enforce rules, and control funds according to its programmed logic.

## EVM
The Ethereum Virtual Machine (EVM) is the runtime that executes smart contract code on Ethereum. Every execution client runs the same rules so the result of a transaction is the same for everyone.

## opcode
An opcode is a single low-level instruction the EVM can execute, like add, store data, load data, or compare values. Smart contract code ultimately runs as a sequence of opcodes.

## receipt
A transaction receipt is the result record produced after a transaction is executed and included in a block. It includes whether it succeeded, how much gas was used, and any logs that were emitted.

## log
A log is an entry emitted during transaction execution that is stored in the receipt. Logs are designed to be searched and filtered efficiently without reading full contract state.

## event
An event is a named log format defined in a smart contract. When a contract “emits an event”, it produces logs with a known structure that apps can listen to.

## topic
A topic is an indexed value stored with a log that helps filtering. Topics are commonly used to filter by event type and by indexed event parameters, making `eth_getLogs` searches faster and more precise.
