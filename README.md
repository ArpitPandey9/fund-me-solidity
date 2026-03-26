# Fund Me Solidity

Protocol-focused Solidity project built through the Cyfrin Updraft **Fund Me** module, covering ETH funding flows, price-feed based minimums, fallback/receive behavior, and contract-level state transitions.

---

## What This Repository Covers

This repository contains Solidity contracts that helped me move from simple storage into more realistic contract behavior.

Main ideas covered in this repo:

- funding a contract with ETH
- enforcing a minimum USD value using a price feed
- tracking funders and funded amounts
- restricting withdrawals to the owner
- understanding `receive()` and `fallback()`
- understanding overflow behavior with `unchecked`

---

## Contracts in This Repository

### 1. `FundMe.sol`

This is the main contract in the repository.

It allows users to fund the contract with ETH only if the ETH sent is worth at least a minimum USD amount.

Main concepts used:

- payable functions
- custom errors
- immutable owner
- mappings
- arrays
- modifiers
- withdrawing ETH from the contract

### 2. `PriceConverter.sol`

This is a Solidity library used by `FundMe.sol`.

It reads the ETH/USD price feed and converts ETH amounts into USD-style values so the contract can check whether the user sent enough ETH.

Main concepts used:

- library
- price-feed based conversion
- working with decimals
- reusable helper functions

### 3. `FallbackExample.sol`

This contract is a small practice contract used to understand what happens when ETH is sent to a contract in different ways.

Main concepts used:

- `receive()`
- `fallback()`
- payable behavior
- how contracts react to unexpected calls

### 4. `SafeMathTester.sol`

This is a small practice contract used to understand arithmetic overflow behavior in Solidity and how `unchecked` changes that behavior.

Main concepts used:

- overflow
- `unchecked`
- Solidity 0.8+ arithmetic behavior

---

## Project Structure

- `FundMe.sol`
- `PriceConverter.sol`
- `FallbackExample.sol`
- `SafeMathTester.sol`

---

## Deep Concept Summary

### Fund Flow

A user sends ETH to the `fund()` function.  
The contract checks whether the ETH sent is worth at least the minimum USD value.  
If the condition passes, the user's address is stored and their funded amount is updated.

### Price Conversion

The contract does not directly compare ETH with USD.  
Instead, it uses a helper library to:

1. get the ETH price
2. scale it properly
3. convert the ETH amount into a USD-based value

### Withdrawal Logic

Only the contract owner should be able to withdraw funds.  
The contract enforces this using ownership logic and a modifier.

### Fallback / Receive Behavior

Contracts can behave differently depending on how ETH or function calls are sent to them.  
This repository includes a small practice file to understand:

- when `receive()` is triggered
- when `fallback()` is triggered

### Overflow Behavior

Solidity 0.8+ checks arithmetic overflow by default.  
The `SafeMathTester` contract helps show what happens when arithmetic is placed inside an `unchecked` block.

---

## How to Run in Remix

1. Open Remix IDE
2. Upload or create these Solidity files
3. Compile the contracts with a compatible Solidity compiler version
4. Deploy `FundMe.sol`
5. Interact with:
   - `fund()` to send ETH
   - `withdraw()` to withdraw contract funds as the owner
6. Deploy `FallbackExample.sol` separately to test `receive()` and `fallback()`
7. Deploy `SafeMathTester.sol` separately to test overflow behavior

---

## What I Learned

From this repository, I learned:

- how ETH funding works in a Solidity contract
- how a minimum funding threshold can be enforced
- how helper libraries improve code reuse
- how ownership restrictions protect withdrawals
- how mappings and arrays are used together
- how fallback and receive functions behave
- how unchecked arithmetic works in Solidity

---

## Protocol-Level Thinking

This repository is important because it starts moving from basic storage contracts to protocol-style thinking.

Questions this repo helps me think about:

- what state does the contract store?
- who is allowed to change that state?
- what conditions must be true before a state change is allowed?
- how does the contract depend on external data like price feeds?
- what can go wrong if contract assumptions fail?

This is the layer where Solidity stops being only syntax and starts becoming system design.

---

## Current Limitation

This repository is still a learning-stage implementation.

It is useful for understanding:

- contract state
- funding flow
- ownership checks
- price-based validation

But it is not yet positioned as a production-ready audited protocol.

---

## Next Step

My next step is to go deeper into:

- full `FundMe` contract understanding
- Remix interaction clarity
- transaction flow
- protocol risks and edge cases
- stronger Solidity foundations before moving further

---
**Arpit Pandey**

GitHub: [ArpitPandey9](https://github.com/ArpitPandey9)
