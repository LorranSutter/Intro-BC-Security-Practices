pragma solidity ^0.6.0;


contract CoinFlipGame {
    constructor() public payable {}

    event LogWin(uint256 amount);
    event LogLose(uint256 amount);

    function bet() public payable {
        require(msg.value <= maxBet(), "bet size too big");

        if (generateRandomBit()) {
            emit LogWin(msg.value);
            msg.sender.transfer(msg.value * 2);
        } else {
            emit LogLose(msg.value);
        }
    }

    function maxBet() public view returns (uint256) {
        return address(this).balance / 10;
    }

    function generateRandomBit() private view returns (bool) {
        bytes32 hash = keccak256(
            abi.encodePacked(
                msg.sender,
                msg.value,
                block.number,
                block.timestamp,
                gasleft()
            )
        );

        return uint256(hash) % 2 == 0;
    }
}
