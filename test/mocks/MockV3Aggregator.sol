// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

/**
 * @title MockV3Aggregator
 * @notice This is a mock contract for local testing of Chainlink Price Feeds
 * @dev Replicates the minimum necessary functionality of the AggregatorV3Interface
 */
contract MockV3Aggregator {
    uint8 public decimals;
    int256 public latestAnswer;

    constructor(uint8 _decimals, int256 _initialAnswer) {
        decimals = _decimals;
        latestAnswer = _initialAnswer;
    }

    function latestRoundData() external view returns (
        uint80 roundId, 
        int256 answer, 
        uint256 startedAt, 
        uint256 updatedAt, 
        uint80 answeredInRound
    ) {
        return (0, latestAnswer, 0, 0, 0);
    }
    
    // Required to prevent compilation warnings during interface interaction
    function version() external pure returns (uint256) {
        return 0;
    }
}