// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/ArcCoin.sol";

contract TestContract is Test {
    ArcCoin c;

    function setUp() public {
        c = new ArcCoin();
    }

    function testMint() public {
        c.mint(address(this), 100);
        assertEq(c.balanceOf(address(this)), 100, "ok");
        assertEq(c.balanceOf(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4), uint(0), "ok");

        c.mint(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,100);
        assertEq(c.balanceOf(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4), 100, "ok");
    }

    function testTransfer() public {
        c.mint(address(this),100);
        c.transfer(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,50);
        assertEq(c.balanceOf(address(this)), 50, "ok");
        assertEq(c.balanceOf(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4), 50, "ok");

        vm.prank(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
        c.transfer(address(this),50);
        assertEq(c.balanceOf(address(this)), 100, "ok");
        assertEq(c.balanceOf(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4), 0, "ok");
    }
}
