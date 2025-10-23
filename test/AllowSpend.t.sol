// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/ArcCoin.sol";

contract TestContract is Test {
    ArcCoin c;

    function setUp() public {
        c = new ArcCoin();
    }

    function testApprovals() public {
        c.mint(address(this), 100);
        c.approve(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 10);

        vm.prank(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
        c.transferFrom(address(this), 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 , 10);

        assertEq(c.balanceOf(address(this)) , 90 , "ok");
        assertEq(c.balanceOf(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4) , 10 , "ok");

        assertEq(c.allowance(address(this), 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4), 0, "ok");
    }

    function test_RevertWhen_TransferExceedsApproval() public {
        c.mint(address(this), 100);
        c.approve(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 10);

        vm.prank(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
        vm.expectRevert();
        c.transferFrom(address(this), 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 , 30);
    }
}
