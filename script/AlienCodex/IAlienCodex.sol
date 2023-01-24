// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAlienCodex {
    function contact() external returns(bool);
    function make_contact() external;
    function record(bytes32 _content) external;
    function retract() external;
    function revise(uint i, bytes32 _content) external;
}