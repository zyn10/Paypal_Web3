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

	struct userName{
		string name;
		bool hasName;
	}

	mapping (address => userName) names;
	mapping (address => request[]) requests;
	mapping (address => sendReceive[]) history;
	

	function addName(string memory _name) public{
		userName storage newUserName = names[msg.sender];
		newUserName.name = _name;
		newUserName.hasName = true;
	}

	function createRequest(address user,uint256 _amount,string memory _message) public {
		
		request memory newRequest;
		newRequest.requestor = msg.sender;
		newRequest.amount = _amount;
		newRequest.message = _message;
		if(names[msg.sender].hasName){
			newRequest.name= names[msg.sender].name;
		}
		requests[user].push(newRequest);
    }

    function payRequest(uint256 _request) public payable {
		
        require(_request < requests[msg.sender].length,"Pay Correct Amount");
        request[] storage myRequests = requests[msg.sender];
        request storage payableRequest = myRequests[_request];
        uint256 toPay = payableRequest.amount;
        require(msg.value == (toPay),"Pay Correct Amount");
        payable(payableRequest.requestor).transfer(msg.value);
        myRequests[_request]=myRequests[myRequests.length-1];
        addHistroy(msg.sender,payableRequest.requestor,payableRequest.amount,payableRequest.message);
        myRequests.pop();

    }

	function addHistroy(address sender,address receiver,uint256 _amount,string memory _message) private {
		
		sendReceive memory newSend;
        newSend.action="-";
        newSend.amount=_amount;
        newSend.message=_message;
        newSend.otherPartyAddress=receiver;
		if(names[receiver].hasName){
			newSend.otherPartyName= names[receiver].name;
		}
		history[sender].push(newSend);

        sendReceive memory newReceive;
        newReceive.action="+";
        newReceive.amount=_amount;
        newReceive.message=_message;
        newReceive.otherPartyAddress=sender;
		if(names[sender].hasName){
			newReceive.otherPartyName= names[sender].name;
		}
		history[receiver].push(newReceive);
    }



}
