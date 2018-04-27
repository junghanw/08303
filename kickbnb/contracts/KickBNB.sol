pragma solidity ^0.4.21;

contract KickBNB {

    address public owner;
    uint public price;
    uint public numGuests;
    uint public numRegisteredGuests;
    mapping(address => bool) public registeredGuests;

    constructor(uint _price, uint _numGuests) public {
        owner = msg.sender;
        price = _price;
        numGuests = _numGuests;
        numRegisteredGuests = 0;
    }

    function deposit() public payable {
        require(msg.value == price / numGuests);
        require(!registeredGuests[msg.sender]);
        registeredGuests[msg.sender] = true;
        numRegisteredGuests++;
    }

    function cancel() public {
        require(registeredGuests[msg.sender]);
        msg.sender.call.value(price / numGuests)();
        registeredGuests[msg.sender] = false;
        numRegisteredGuests--;
    }

    function confirm() public {
        require(msg.sender == owner);
        require (numRegisteredGuests == numGuests);
        selfdestruct(owner);
    }
}
