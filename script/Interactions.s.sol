// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

/**
 * @title FundFundMe
 * @author Arpit Pandey
 * @notice Script to automate the funding of the most recently deployed FundMe contract
 * @dev Utilizes DevOpsTools to dynamically fetch the target contract address
 */
contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.1 ether;

    /**
     * @notice Main execution function invoked by Forge
     */
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        fundFundMe(mostRecentlyDeployed);
    }

    /**
     * @notice Executes the fund transaction to the target contract
     * @param mostRecentlyDeployed The address of the deployed FundMe instance
     */
    function fundFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        
        console.log("Successfully funded FundMe contract at:", mostRecentlyDeployed);
        console.log("Amount funded:", SEND_VALUE);
    }
}

/**
 * @title WithdrawFundMe
 * @author Arpit Pandey
 * @notice Script to automate withdrawing funds from the most recently deployed FundMe contract
 * @dev Utilizes DevOpsTools to dynamically fetch the target contract address
 */
contract WithdrawFundMe is Script {
    
    /**
     * @notice Main execution function invoked by Forge
     */
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        withdrawFundMe(mostRecentlyDeployed);
    }

    /**
     * @notice Executes the withdrawal transaction from the target contract
     * @param mostRecentlyDeployed The address of the deployed FundMe instance
     */
    function withdrawFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).cheaperWithdraw();
        vm.stopBroadcast();
        
        console.log("Successfully withdrew from FundMe contract at:", mostRecentlyDeployed);
    }
}