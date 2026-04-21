// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

/**
 * @title FundMe Protocol Sandbox
 * @author Arpit Pandey
 * @notice A sandbox contract demonstrating EVM state management, oracle integrations, and gas optimization.
 * @dev Implements PriceConverter library and utilizes memory caching to minimize SLOAD operations.
 */
contract FundMe {
    using PriceConverter for uint256;

    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;
    address public immutable I_OWNER;
    uint256 public constant MINIMUM_USD = 5 * 1e18;
    AggregatorV3Interface private sPriceFeed;

    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    constructor(address priceFeedAddress) {
        require(priceFeedAddress != address(0), "Invalid price feed");
        I_OWNER = msg.sender;
        sPriceFeed = AggregatorV3Interface(priceFeedAddress);
    }

    function _checkOwner() internal view {
        require(msg.sender == I_OWNER, "Unauthorized: Caller is not the owner");
    }

    function fund() public payable {
        require(msg.value.getConversionRate(sPriceFeed) >= MINIMUM_USD, "Insufficient ETH sent");
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function withdraw() public onlyOwner {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);

        (bool callSuccess, ) = payable(I_OWNER).call{value: address(this).balance}("");
        require(callSuccess, "ETH transfer failed");
    }

    function cheaperWithdraw() public onlyOwner {
        address[] memory mFunders = funders;

        for (uint256 funderIndex = 0; funderIndex < mFunders.length; funderIndex++) {
            address funder = mFunders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);

        (bool success, ) = payable(I_OWNER).call{value: address(this).balance}("");
        require(success, "ETH transfer failed");
    }
}