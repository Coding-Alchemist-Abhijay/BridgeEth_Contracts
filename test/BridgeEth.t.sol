
// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import {TEST} from "forge-std/Test.sol";

import {bridgeEth} from "../src/bridgeEth.sol";
import {USDT} from "../src/USDT.sol";

contract BridgeEthTest is Test {
    event Transfer(address indexed from, address indexed to, uint256 value);

    bridgeEth bridge;
    USDT usdt;

    function setUp() public {
        usdt = new USDT();
        bridge = new bridgeEth(address(usdt));
    }

    function test_Deposit() public {
        usdt.mint(0x2966473D85A76A190697B5b9b66b769436EFE8e5, 200);
        vm.startPrank(0x2966473D85A76A190697B5b9b66b769436EFE8e5);
        usdt.approve(address(bridge), 200);

        bridge.deposit(address(usdt), 200);
        assertEq(usdt.balanceOf(0x2966473D85A76A190697B5b9b66b769436EFE8e5), 0);
        assertEq(usdt.balanceOf(address(bridge)), 200);
    }

    
}

