// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {USDT} from "../src/USDT.sol";

contract DeployMyToken is Script {
    function run() external {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerKey);

        new USDT(); 

        vm.stopBroadcast();
    }
}
