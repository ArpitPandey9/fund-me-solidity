// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

/**
 * @title DeployFundMe
 * @notice Script to deploy the FundMe contract and inject the correct price feed address
 */
contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        // --- 1. PRE-BROADCAST PHASE (Gas Saved) ---
        // Anything before startBroadcast is NOT sent as a real transaction
        // It runs in a simulated environment to save gas.
        HelperConfig helperConfig = new HelperConfig();
        
        // Extracting the price feed address from the struct
        address ethUsdPriceFeed = helperConfig.activeNetworkConfig();

        // --- 2. BROADCAST PHASE (Real Transaction) ---
        // Everything between start and stop broadcast is an actual transaction 
        // that costs gas on the real blockchain.
        vm.startBroadcast();
        
        // Deploying FundMe and injecting the dynamically fetched address
        FundMe fundMe = new FundMe(ethUsdPriceFeed);
        
        vm.stopBroadcast();
        
        return fundMe;
    }
}