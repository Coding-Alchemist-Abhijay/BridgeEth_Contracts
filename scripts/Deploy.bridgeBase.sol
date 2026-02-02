// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {bridgeBase} from "../src/bridgeBase.sol";
import {BUSDT} from "../src/BUSDT.sol";

contract DeployMyToken is Script {
    function run() external {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerKey);

        BUSDT busdt = new BUSDT();
        new bridgeBase(address(busdt)); 

        vm.stopBroadcast();
    }
}
