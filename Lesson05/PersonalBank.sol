pragma solidity ^0.6.0;

// Deploy with 10 ether in the value
// Store the hash of to, amout and a nonce to check in the future (mapping)
// Must have the contract address as signature too in sign-cheque.js

contract PersonalBank {
    address owner;
    mapping(bytes32 => bool) private transactions;

    constructor() public payable {
        owner = msg.sender;
    }

    receive() external payable {}

    function cashCheque(
        address payable to,
        uint256 amount,
        bytes32 nonce,
        bytes32 r,
        bytes32 s,
        uint8 v
    ) public {
        bytes32 newTransaction = keccak256(abi.encodePacked(to, amount, nonce));

        require(!transactions[newTransaction], "not a new transaction");

        bytes32 messageHash = keccak256(
            abi.encodePacked(address(this), to, amount, nonce)
        );

        bytes32 messageHash2 = keccak256(
            abi.encodePacked("\x19Ethereum Signed Message:\n32", messageHash)
        );

        require(ecrecover(messageHash2, v, r, s) == owner, "bad signature");

        transactions[newTransaction] = true;

        to.transfer(amount);
    }
}
