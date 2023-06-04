// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Paypal {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    struct request {
        address requestor;
        uint256 amount;
        string message;
        string name;
    }

	struct sendReceive{
		string action;
		uint256 amount;
		string message;
		address otherPartyAddress;
		string otherPartyName;
	}

}
