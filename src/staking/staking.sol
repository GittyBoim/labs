// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

ipmort './erc20.sol';

struct User {
    uint amount;
    uint time;
}

contract staking {

    uint reward =1000000;

    uint toatalSupplay;

    mapping (address => User) staking;
    
    IERC20 c;

    constructor(address _token) public {
        token= IERC20(_token);
    } 

    function stake(uint amount) public {
        staking[msg.sender].amount += amount;
        c.transferFrom(address(this), amount);
    }

    function withdraw() public {
        amount = 
        staking[msg.sender] -= amount;
        c.transfer(msg.sender, amount);
    }

}