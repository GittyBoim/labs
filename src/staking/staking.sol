// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import "./erc20.sol";

struct User {
    uint amount;
    uint time;
}

contract stakingContract {

    uint public reward; 

    mapping (address => User) public staking;
    
    MyToken t;

    constructor(address _token) public {
        t = MyToken(_token);
        t.mint(address(this), 1000000);
        reward = 1000000;
    } 

    function stake(uint amount) public {
        staking[msg.sender].amount += amount;
        staking[msg.sender].time = block.timestamp;
        t.transferFrom(msg.sender, address(this), amount);
    }

    function withdarw() public {
        uint amount = staking[msg.sender].amount;
        staking[msg.sender].amount = 0;
        reward -= calcReward();
        t.transfer(msg.sender, amount + calcReward());
    }

    function calcReward() public view returns (uint256) {
        if(block.timestamp - staking[msg.sender].time < 7)
            return 0;
        uint userReward = (staking[msg.sender].amount / (t.balanceOf(address(this)) - reward)) * reward;
        return userReward;
    }

}