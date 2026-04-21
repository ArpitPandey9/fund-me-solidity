// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

/**
 * @title FundMe System Tests
 * @author Arpit Pandey
 * @notice Integration and unit tests for the FundMe protocol architecture.
 */
contract FundMeTest is Test {
    FundMe fundMe;

    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;

    function setUp() public {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testMinimumDollarIsFive() public view {
        assertEq(fundMe.MINIMUM_USD(), 5 * 1e18);
    }

    function testOwnerIsMsgSender() public view {
    address expectedOwner = 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38;
    assertEq(fundMe.I_OWNER(), expectedOwner);

    }

    function testFundFailsWithoutEnoughEth() public {
        vm.prank(USER);
        vm.expectRevert();
        fundMe.fund{value: 1 wei}();
    }

    function testFundUpdatesFundedDataStructure() public {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();

        uint256 amountFunded = fundMe.addressToAmountFunded(USER);
        assertEq(amountFunded, SEND_VALUE);
    }

    function testAddsFunderToArray() public {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();

        address firstFunder = fundMe.funders(0);
        assertEq(firstFunder, USER);
    }

    function testFundingAccumulatesForSameUser() public {
        vm.startPrank(USER);
        fundMe.fund{value: SEND_VALUE}();
        fundMe.fund{value: SEND_VALUE}();
        vm.stopPrank();

        assertEq(fundMe.addressToAmountFunded(USER), SEND_VALUE * 2);
    }

    function testOnlyOwnerCanWithdraw() public {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();

        vm.expectRevert();
        vm.prank(USER);
        fundMe.withdraw();
    }

    function testWithdrawWithSingleFunder() public {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();

        uint256 startingOwnerBalance = fundMe.I_OWNER().balance;
        uint256 startingFundMeBalance = address(fundMe).balance;

        vm.prank(fundMe.I_OWNER());
        fundMe.withdraw();

        uint256 endingOwnerBalance = fundMe.I_OWNER().balance;
        uint256 endingFundMeBalance = address(fundMe).balance;

        assertEq(endingFundMeBalance, 0);
        assertEq(startingOwnerBalance + startingFundMeBalance, endingOwnerBalance);
        assertEq(fundMe.addressToAmountFunded(USER), 0);

        vm.expectRevert();
        fundMe.funders(0);
    }

    function testWithdrawFromMultipleFunders() public {
        uint160 numberOfFunders = 10;
        uint160 startingFunderIndex = 1;

        for (uint160 i = startingFunderIndex; i < numberOfFunders + startingFunderIndex; i++) {
            address funder = address(i);
            hoax(funder, STARTING_BALANCE);
            fundMe.fund{value: SEND_VALUE}();
        }

        uint256 startingOwnerBalance = fundMe.I_OWNER().balance;
        uint256 startingFundMeBalance = address(fundMe).balance;

        vm.prank(fundMe.I_OWNER());
        fundMe.withdraw();

        uint256 endingOwnerBalance = fundMe.I_OWNER().balance;
        uint256 endingFundMeBalance = address(fundMe).balance;

        assertEq(endingFundMeBalance, 0);
        assertEq(startingOwnerBalance + startingFundMeBalance, endingOwnerBalance);
        assertEq(fundMe.addressToAmountFunded(address(1)), 0);

        vm.expectRevert();
        fundMe.funders(0);
    }

    function testCheaperWithdrawFromMultipleFunders() public {
        uint160 numberOfFunders = 10;
        uint160 startingFunderIndex = 1;

        for (uint160 i = startingFunderIndex; i < numberOfFunders + startingFunderIndex; i++) {
            address funder = address(i);
            hoax(funder, STARTING_BALANCE);
            fundMe.fund{value: SEND_VALUE}();
        }

        uint256 startingOwnerBalance = fundMe.I_OWNER().balance;
        uint256 startingFundMeBalance = address(fundMe).balance;

        vm.prank(fundMe.I_OWNER());
        fundMe.cheaperWithdraw();

        uint256 endingOwnerBalance = fundMe.I_OWNER().balance;
        uint256 endingFundMeBalance = address(fundMe).balance;

        assertEq(endingFundMeBalance, 0);
        assertEq(startingOwnerBalance + startingFundMeBalance, endingOwnerBalance);
        assertEq(fundMe.addressToAmountFunded(address(1)), 0);

        vm.expectRevert();
        fundMe.funders(0);
    }
}