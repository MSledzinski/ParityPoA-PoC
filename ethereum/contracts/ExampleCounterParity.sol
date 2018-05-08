pragma solidity ^0.4.18;

contract ExampleCounterParity {

    address owner;
    uint256 public minimumAmountInWei;

    uint256 public counter;

    constructor(uint256 minimum) public {
        owner = msg.sender;
        minimumAmountInWei = minimum;
    }

    modifier ownerOnly {
        require(msg.sender == owner);
        _;
    }

    function increment() public payable returns (uint256) {
        require(msg.value >= minimumAmountInWei);

        uint256 newCounter = counter + 1;
        
        require(newCounter > counter);
        
        counter = newCounter;

        return counter;
    }

    function reset() public ownerOnly {
        counter = 0;
    }
}