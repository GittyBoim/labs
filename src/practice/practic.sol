// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract helloWorld {
    string public great = "hello world!";
}

contract counter {

    uint public count;

    function get() public view returns(uint256) {
        return count;
    }

    function inc() public {
        count++;
    }

    function dec() public {
        count--;
    }

}