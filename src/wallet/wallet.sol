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

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    modifier isOwner {
        require(msg.sender == mainOwner || owners[msg.sender], "Wallet not owner");
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

    function deleteOwner(address owner) public {
        require(msg.sender == mainOwner, "Wallet not mainOwner");
        require(owners[owner], "Owner not exists");
        delete owners[owner];
        countOwners --;
    }
}
