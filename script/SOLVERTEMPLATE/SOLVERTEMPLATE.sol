// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.0 <0.9.0; // flexible is better, no?

import "forge-std/Script.sol";
import "src/SOLVERTEMPLATE/SOLVERTEMPLATE.sol";

contract SOLVERTEMPLATEScript is Script {

    SOLVERTEMPLATE target;

    function setUp() public {
        /** SETUP SCENARIO - NO NEED TO CHANGE ANYTHING HERE */
        if (block.chainid == 5) { //goerli chian
            target = SOLVERTEMPLATE(0x0000000000000000000000000000000000000000); //attach to an address
        }else{ // local - chainid = 31137
            target = new SOLVERTEMPLATE();
        }
    }

    function run() public {
        /** CODE YOUR EXPLOIT HERE **/
        
    }
}
