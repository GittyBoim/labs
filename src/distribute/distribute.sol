// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract distributeContract {

    address[] public addressList;

    constructor() {}

    function addUser(address user) public payable {
        addressList.push(user);
    }

    function distribute() external payable {

        require(addressList.length > 0, "0 users");

        uint amountToDistribute = msg.value / addressList.length;

        for (uint i = 0; i < addressList.length; i++) {
            payable(addressList[i]).transfer(amountToDistribute);
        }
    }
}
