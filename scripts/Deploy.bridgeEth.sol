// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {bridgeEth} from "../src/bridgeEth.sol";
import {USDT} from "../src/USDT.sol";

contract DeployMyToken is Script {
    function run() external {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerKey);

        USDT usdt = new USDT();
        new bridgeEth(address(usdt)); 

        vm.stopBroadcast();
    }
}
