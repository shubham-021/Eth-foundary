// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";


contract AllowSpend is ERC20 , Ownable {
    
    constructor() ERC20("Arka","ARC") Ownable(msg.sender){}

    function mint(address to , uint256 value) public{
        _mint(to , value);
    }
 }
