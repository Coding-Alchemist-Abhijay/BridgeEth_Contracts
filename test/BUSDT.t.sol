// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";

import {BUSDT} from "../src/BUSDT.sol";

contract TestBUSDT is Test {
    BUSDT public token;

    function setUp() public {
        token = new BUSDT();
    }

    function testMint() public {
        token.mint(address(this), 100);
        assertEq(token.balanceOf(address(this)), 110, "ok");
    }

    function testBurn() public {
        token.burn(address(this), 10);
        assertEq(token.balanceOf(address(this)), 0, "ok");
    }

    function test_RevertIf_Mint() public {
        token.mint(address(this), 100);
        assertEq(token.balanceOf(address(this)), 100, "ok");
    }

    function test_RevertIf_Burn() public {
        token.burn(address(this), 10);
        assertEq(token.balanceOf(address(this)), 10, "ok");
    }

    function test_RevertIf_BurnWithoutBalance() public {
        vm.expectRevert("Insufficient balance");
        token.burn(address(this), 20);
    }

}
