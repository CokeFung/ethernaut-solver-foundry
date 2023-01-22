// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/SOLVERTEMPLATE/SOLVERTEMPLATE.sol";

contract SOLVERTEMPLATETest is Test {
    SOLVERTEMPLATE public target;
    function setUp() public {
       target = new SOLVERTEMPLATE();
       target.setNumber(0);
    }

    function testIncrement() public {
        target.increment();
        assertEq(target.number(), 1);
    }

    function testSetNumber(uint256 x) public {
        target.setNumber(x);
        assertEq(target.number(), x);
    }
}
