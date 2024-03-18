// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Owner {

    address public owner;
    address[3] public gabaiim;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    modifier isOwnerOrGabai() {
        require(msg.sender == gabaiim[0] || msg.sender == gabaiim[1] || msg.sender == gabaiim[2] || msg.sender == owner, "Wallet not owner or gabai");
        _;
    }

    function withdraw(uint sum) public isOwnerOrGabai {
        payable(msg.sender).transfer(sum);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function addGabai(address newGabai) public {
        require(msg.sender == owner, "WALLET-not-owner");
        if(gabaiim[0] == address(0))
            gabaiim[0] == newGabai;
        if(gabaiim[1] == address(0))
            gabaiim[1] == newGabai;
        if(gabaiim[2] == address(0))
            gabaiim[2] == newGabai;
        revert 
    }
}
