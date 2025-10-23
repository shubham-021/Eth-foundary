// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/ArcCoin.sol";

contract TestContract is Test {
    ArcCoin c;
    // every event can have upto 3 indexed parameters
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);


    function setUp() public {
        c = new ArcCoin();
    }

    function testEmitTransfer() public {
        c.mint(address(this), 100);
        vm.expectEmit(true, true, false, true);
        // first three boolean to let it know if to compare those respective indexed field , fourth boolean for 
        // all the non indexed paramters , if false it will not be compared

        // since for this event , it has only 2 indexed field , the third boolean value doesnt matter , be it false or true
        

        // the event we expect
        emit Transfer(address(this), 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 50);

        // the event we get
        c.transfer(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 50);
    }

    // making the fourth boolean false, and testing whats happening
    function testEmitTransferWithFalse() public {
        c.mint(address(this), 100);
        vm.expectEmit(true, true, false, false);
        emit Transfer(address(this), 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 50);
        c.transfer(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 80);
    }

    // test ran successfully , but the transfer amount is not same in the emit and actual transfer call,
    // all because of the false ( which skips the comparision between all the non indexed paramters )

    function testEmitApproval() public {
        c.mint(address(this), 100);
        vm.expectEmit(true, true, false, true);
        emit Approval(address(this), 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 80);
        c.approve(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 80);
    }
}
