// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/AllowSpend.sol";

contract TestContract is Test {
    AllowSpend c;

    function setUp() public {
        c = new AllowSpend();
    }
}
