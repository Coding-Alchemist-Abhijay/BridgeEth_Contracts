// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";   

contract BUSDT is ERC20, Ownable{ 
    
    constructor() ERC20("BUSDT","BUSDT") Ownable(msg.sender) {
        _mint(msg.sender, 10);
    }
    
    function mint(address _to, uint256 _amount) public onlyOwner {
        _mint(_to, _amount);
    }

    function burn(address _from , uint256 _amount) public onlyOwner {
        _burn(_from, _amount);
    }

    function decimals() public view override onlyOwner returns (uint8) {
        return 1;
    }
}