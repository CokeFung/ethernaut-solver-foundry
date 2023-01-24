// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.0 <0.9.0; // flexible is better, no?

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "src/HelloEthernaut/Instance.sol";

contract InstanceScript is Script {

    address internal attacker;
    address internal deployer;
    Instance target;

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
            target = Instance(0x0000000000000000000000000000000000000000); //attach to an existing contract
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
            target = new Instance("P@SSW0rd#123!!!");
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
        console.log("target   : %s", address(target));

        console.log("[Exploit]");
        console.log("info() : %s", target.info());
        console.log("info1() : %s", target.info1());
        console.log("info2() : %s", target.info2("hello"));
        console.log("infoNum() : %s", target.infoNum());
        console.log("info42() : %s", target.info42());
        console.log("theMethodName() : %s", target.theMethodName());
        console.log("method7123949() : %s", target.method7123949());
        string memory password = target.password();
        console.log("password() : %s", target.password());
        vm.startBroadcast(attacker);
        target.authenticate(password);
        vm.stopBroadcast();
        console.log("cleared() : %s", target.getCleared());
    }
}