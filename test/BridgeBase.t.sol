
// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";

import {bridgeBase} from "../src/bridgeBase.sol";
import {BUSDT} from "../src/BUSDT.sol";

contract BridgeBaseTest is Test {
    event Transfer(address indexed from, address indexed to, uint256 value);

    bridgeBase bridge;
    BUSDT busdt;

    function setUp() public {
        busdt = new BUSDT();
        bridge = new bridgeBase(address(busdt));
    }

    function test_Burn() public {
        busdt.mint(0x2966473D85A76A190697B5b9b66b769436EFE8e5, 200);
        vm.startPrank(0x2966473D85A76A190697B5b9b66b769436EFE8e5);

        bridge.burn(0x2966473D85A76A190697B5b9b66b769436EFE8e5, 200);
        assertEq(busdt.balanceOf(0x2966473D85A76A190697B5b9b66b769436EFE8e5), 0);
        assertEq(busdt.balanceOf(address(bridge)), 0);
    }
}

