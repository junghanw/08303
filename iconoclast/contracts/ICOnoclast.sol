pragma solidity ^0.4.21;

contract ICOnoclast {

    // ERC20
    string public constant name = "ICOnoclast";
    string public constant symbol = "ICN";
    uint8 public constant decimals = 18;

    // Keep track of data needed for ERC20 functions
    address owner;
    mapping (address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;
    uint256 _totalSupply; // avoid conflict with totalSupply() ERC20 function
    uint256 presaleEnd;
    uint256 lastWithdraw;

    constructor() public payable {
        owner = msg.sender;
        balances[msg.sender] = msg.value;
        _totalSupply = msg.value;
        presaleEnd = now + (3 days);
    }

    function withdraw(uint256 amount) public {
        // Don't allow withdrawals unless the following conditions are met
        require(now >= presaleEnd);
        require(msg.sender == owner);
        require(amount != 0 && amount <= address(this).balance);
        require(now >= lastWithdraw + (1 days));
        require(_totalSupply - address(this).balance + (1 ether) >= amount);

        // Send funds and update last withdraw time
        require(owner.send(amount));
        lastWithdraw = now;
    }

    function () public payable {
        require (now < presaleEnd);
        balances[msg.sender] += msg.value;
        _totalSupply += msg.value;
    }

    // ERC20 functions

    function totalSupply() public view returns (uint) {
        return _totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _amount) public returns (bool) {
        if (now < presaleEnd || balances[msg.sender] < _amount
                || _amount == 0) {
            return false;
        }

        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        return true;
    }

    function transferFrom(address _from, address _to,
                                                uint256 _amount) public returns (bool) {
        if (now < presaleEnd || allowed[_from][msg.sender] < _amount
                || balances[_from] < _amount || _amount == 0) {
            return false;
        }
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        return true;
    }

    function approve(address _spender,
                                     uint256 _amount) public returns (bool) {
        allowed[msg.sender][_spender] = _amount;
        return true;
    }
}
