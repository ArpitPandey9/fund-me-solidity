# Fund Me Solidity

Protocol-focused Solidity project built through the Cyfrin Updraft **Fund Me** module, covering ETH funding flows, price-feed based minimums, fallback/receive behavior, and contract-level state transitions.

---

## What This Repository Covers

This repository contains Solidity contracts that helped me move from simple state storage into more realistic contract behavior.

Main ideas covered in this repo:

- funding a contract with ETH
- enforcing a minimum USD value using a price feed
- tracking funders and funded amounts
- restricting withdrawals to the owner
- understanding `receive()` and `fallback()`
- understanding overflow behavior with `unchecked`

---

## Contracts in This Repository

### 1. `FundME.sol`
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

---

### 2. `PriceConverter.sol`
This is a Solidity library used by `FundME.sol`.

It reads the ETH/USD price feed and converts ETH amounts into USD-style values so the contract can check whether the user sent enough ETH.

Main concepts used:
- library
- price-feed based conversion
- working with decimals
- reusable helper functions

---

### 3. `FallbackExample.sol`
This contract is a small practice contract used to understand what happens when ETH is sent to a contract in different ways.

Main concepts used:
- `receive()`
- `fallback()`
- payable behavior
- how contracts react to unexpected calls

---

### 4. `SafeMathTester.sol`
This is a small practice contract used to understand arithmetic overflow behavior in Solidity and how `unchecked` changes that behavior.

Main concepts used:
- overflow
- `unchecked`
- Solidity 0.8+ arithmetic behavior

---

## Project Structure

```text
fund-me-solidity/
│
├── FundME.sol
├── PriceConverter.sol
├── FallbackExample.sol
└── SafeMathTester.sol
