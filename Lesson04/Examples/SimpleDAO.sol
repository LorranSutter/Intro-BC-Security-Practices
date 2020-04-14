pragma solidity ^0.6.0;


contract SimpleDAO {
    mapping(address => uint256) public balance;

    function deposit() public payable {
        balance[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(balance[msg.sender] >= amount, "not enough balance");
        msg.sender.call.value(amount)("");
        balance[msg.sender] -= amount;
    }
}
