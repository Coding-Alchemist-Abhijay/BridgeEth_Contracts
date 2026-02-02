// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";  
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol"; 

interface IUSDT is IERC20{
    function allowance(address _owner, address _spender) external view returns (uint256 remaining);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
    function transfer(address _to, uint256 _value) external returns (bool success);
}

contract bridgeEth is Ownable{ 
    address tokenAddress;
    mapping(address => uint256) public pendingBalance;

    event Deposit(address indexed depositor, uint amount);

    constructor(address _tokenAddress) Ownable(msg.sender) {
        tokenAddress = _tokenAddress;
    }

    function deposit(address _tokenAddress, uint256 _amount) public {
        require(_tokenAddress == tokenAddress);
        require(IUSDT(tokenAddress).allowance(msg.sender, address(this)) >= _amount, "Insufficient allowance");  
        require(IUSDT(tokenAddress).transferFrom(msg.sender, address(this), _amount));
        emit Deposit(msg.sender, _amount);
    }

    function withdraw(address _tokenAddress, uint256 _amount) public {
        require(_tokenAddress == tokenAddress);
        require(pendingBalance[msg.sender] >= _amount);
        pendingBalance[msg.sender] -= _amount;        
        IUSDT(tokenAddress).transfer(msg.sender, _amount);
    }

    function burnedOnOppositeChain(address userAccount, uint256 _amount) public onlyOwner {
        pendingBalance[userAccount] += _amount;
    }
}