# fund-me-solidity

Foundry-based Solidity project for the FundMe module, focused on:

- ETH funding with minimum USD validation
- Chainlink price feed integration
- owner-restricted withdrawals
- gas-optimized withdrawal flow
- deployment and interaction scripts
- mock-based local testing

## What this repository contains

### 1. FundMe contract
Core protocol contract covering:
- funding with ETH
- minimum USD threshold
- funder tracking
- mapping-based contribution accounting
- owner-only withdraw
- cheaper withdraw optimization

### 2. PriceConverter library
Library used to:
- read ETH/USD price data from Chainlink
- convert ETH amount to USD-denominated value
- support funding threshold checks

### 3. HelperConfig script
Configuration logic for:
- Sepolia price feed address
- local Anvil mock deployment
- environment-specific setup

### 4. Deploy script
Deployment automation for:
- setting up config
- injecting price feed address
- deploying FundMe

### 5. Interaction scripts
Scripts to:
- fund the most recently deployed FundMe contract
- withdraw from the most recently deployed FundMe contract

### 6. Mock contracts
Local testing support through:
- `MockV3Aggregator`

## Project structure

### Source
- `src/FundMe.sol`
- `src/PriceConverter.sol`

### Scripts
- `script/DeployFundMe.s.sol`
- `script/HelperConfig.s.sol`
- `script/Interactions.s.sol`

### Tests
- `test/FundMe.t.sol`
- `test/mocks/MockV3Aggregator.sol`

## Test coverage

This checkpoint includes tests for:
- minimum USD constant
- owner assignment
- funding revert when ETH is too low
- funder array update
- mapping update after funding
- repeated funding accumulation
- owner-only withdraw restriction
- withdraw with a single funder
- withdraw with multiple funders
- cheaperWithdraw with multiple funders

## How to run locally

```bash
forge build
forge test
forge test -vvvv
```

## Key concepts practiced

- payable functions
- msg.sender / msg.value
- Chainlink price feeds
- libraries
- mappings
- dynamic arrays
- constructor-based ownership
- modifiers
- external value transfer
- gas optimization with memory caching
- Foundry scripts
- local mocks
- integration-style testing

## Current milestone

This repository now represents a Foundry-based FundMe checkpoint with:
- working contract logic
- deployment/config/interaction scripts
- local mock setup
- strong automated test coverage

## Next direction

- script flow polish
- protocol-level explanation improvements
- stronger portfolio signal before outreach