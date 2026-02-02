
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { console } from "forge-std/console.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

interface IBUSDT is IERC20 {
    function mint(address _to, uint256 _amount) external;
    function burn(address _from, uint256 _amount) external;
}

contract bridgeBase is Ownable {
    uint256 public balance;
    address public tokenAddress;

    event Burn(address indexed burner, uint amount);

    mapping(address => uint256) public pendingBalance;

    constructor(address _tokenAddress) Ownable(msg.sender) {
        tokenAddress = _tokenAddress;
    }

    function burn(address _tokenAddress, uint256 _amount) public {
        require(_tokenAddress == tokenAddress);
        IBUSDT(tokenAddress).burn(msg.sender, _amount);
        emit Burn(msg.sender, _amount);
    }

    function withdraw(address _tokenAddress, uint256 _amount) public {
        require(pendingBalance[msg.sender] >= _amount);
        pendingBalance[msg.sender] -= _amount;
        IBUSDT(tokenAddress).mint(msg.sender, _amount);
    }

    function depositedOnOppositeChain(address userAccount, uint256 _amount) public onlyOwner {
        pendingBalance[userAccount] += _amount;
    }
}