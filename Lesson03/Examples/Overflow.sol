pragma solidity ^0.6.0;

contract TestOverflow {
    function addOne(uint256 a) public pure returns(uint256) {
        require(a + 1 > a, "sorry, a is too big");
        return a + 1;
    }
}