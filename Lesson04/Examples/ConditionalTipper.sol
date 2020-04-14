pragma solidity ^0.6.0;

// This is to be used with tipjar lab from previous class
// You deploy tipjar and tip some amount
// Then you the tipjar address and uses it as a parameter along with a limit to deploy this contract
// Include a tip in value to deploy this contract too
// If your tip is greater than the limit, you will receive a refund with the diference between your tip and the limit
contract ConditionalTipper {
    constructor(address payable tipjar, uint256 limit) public payable {
        if (tipjar.balance < limit) {
            tipjar.transfer(limit - tipjar.balance);
        }

        selfdestruct(msg.sender);
    }
}