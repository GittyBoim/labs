// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Wallet {

    address public mainOwner;
    mapping (address => bool) public owners;
    uint public countOwners = 0;

    constructor() {
        mainOwner = msg.sender;
    }

    receive() external payable {}

     function getCountOwners() public view returns (uint) {
        return countOwners;
    }

    function getMainOwner() public view returns (address) {
        return mainOwner;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    modifier isOwner {
        require(msg.sender == mainOwner || owners[msg.sender], "Wallet not mainOwner");
        _;
    }

    function withdraw(uint sum) public isOwner {
        payable(msg.sender).transfer(sum);
    }

    function addOwner(address newOwner) public {
        require(msg.sender == mainOwner, "Wallet not mainOwner");
        require(countOwners < 3, "There are already 3 owners cant add owner");
        require(!owners[newOwner], "Owner already exists");
        owners[newOwner] = true;
        countOwners++;
    }

}
