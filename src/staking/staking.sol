// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import "./erc20.sol";

struct Staking {
    uint amount;
    uint time;
}

contract stakingContract {

    uint public reward;

    mapping (address => Staking) public staking;

    MyToken t;

    uint wad = 1e18;

    constructor(address _token) public {
        t = MyToken(_token);
        t.mint(address(this), 1000000 *  1e18);
        reward = 1000000 * 1e18;
    }

    function stake(uint amount) public {
        require(amount > 0, "Cant stack this amount");
        staking[msg.sender].amount += amount;
        staking[msg.sender].time = block.timestamp;
        t.transferFrom(msg.sender, address(this), amount);
    }

    function withdarw() public {
        uint amount = staking[msg.sender].amount;
        amount += calcReward();
        staking[msg.sender].amount = 0;
        reward -= calcReward();
        t.transfer(msg.sender, amount);
    }

    function calcReward() public view returns (uint256) {
        require(block.timestamp - staking[msg.sender].time >= 7, "Cand withdraw befor 7 days");
        uint userReward = (staking[msg.sender].amount / (t.balanceOf(address(this)) - reward)) * reward * 2 / 100;
        return userReward;
    }

}
