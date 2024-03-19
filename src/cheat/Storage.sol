// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Storage {

    uint256 number;

    //store value in num variable
    function store(uint256 num) public {
        number = num;
    }

    //return value of num
    //view - declare that the function does not change the state of the contract
    function retrieve() public view returns (uint256) {
        return number;
    }
}

