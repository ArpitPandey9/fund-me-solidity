
// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


library PriceConverter {

    function getPrice() public view returns (uint256) {
        // Sepolia ETH / USD price feed
        AggregatorV3Interface priceFeed =
            AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);

        // latestRoundData returns:
        // (roundId, answer, startedAt, updatedAt, answeredInRound)
        (, int256 price, , ,) = priceFeed.latestRoundData();

        // Chainlink price has 8 decimals
        // Convert to 18 decimals by multiplying by 1e10
        return uint256(price) * 1e10;
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();

        // ethPrice has 18 decimals
        // ethAmount is in wei (18 decimals)
        // result will also be scaled to 18 decimals
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;

        return ethAmountInUsd;
    }
}