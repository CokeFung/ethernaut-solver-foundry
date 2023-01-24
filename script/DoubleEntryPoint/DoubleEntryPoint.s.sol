// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.0 <0.9.0; // flexible is better, no?

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "src/DoubleEntryPoint/DoubleEntryPoint.sol";
import "./DetectionBot.sol";

contract DoubleEntryPointScript is Script {

    address internal attacker;
    address internal deployer;
    DoubleEntryPoint target;

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
            target = DoubleEntryPoint(0x0000000000000000000000000000000000000000); //attach to an existing contract
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
            LegacyToken LGT = new LegacyToken();
            CryptoVault vault = new CryptoVault(deployer);
            Forta forta = new Forta();
            target = new DoubleEntryPoint(
                address(LGT),
                address(vault),
                address(forta),
                address(attacker)
            );
            vault.setUnderlying(address(target));
            LGT.delegateToNewContract(DelegateERC20(target));
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

        vm.startBroadcast(attacker);
        DetectionBot bot = new DetectionBot(
            target.player(),
            target.forta(),
            target.cryptoVault(),
            IERC20(target)
        );
        target.forta().setDetectionBot(address(bot));
        vm.stopBroadcast();
    }
}