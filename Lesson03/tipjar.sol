pragma solidity ^0.6.0;

contract tipjar {
    
    address payable owner;
    
    constructor() public payable {
        owner = msg.sender;
    }
    
    receive () external payable {
    }
    
    modifier onlyOwner(){
        if(msg.sender != owner){
            revert("not owner");
        }
        _;
    }
    
    function withdraw() public onlyOwner {
        owner.transfer(address(this).balance);
    }
    
    function checkJarBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function transferOwnership(address payable newOwner) public onlyOwner {
        owner = newOwner;
    }
}