// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/staking/staking.sol";
import "@hack/staking/erc20.sol";

contract TestStaking is Test {

    StakingContract s;
    MyToken t;

    function setUp() public {
        t = new MyToken();
        s = new StakingContract(address(t));
    }

    function testMint(uint256 amount) public {
        uint totalSupply = t.totalSupply();
        vm.assume(amount <=  type(uint256).max - totalSupply);
        t.mint(address(this), amount);
        assertEq(t.balanceOf(address(this)), amount);
    }

    function testStake(uint256 amount) public {
        uint totalSupply = t.totalSupply();
        vm.assume(amount <=  type(uint256).max - totalSupply && amount > 0);
        t.mint(address(this), amount);
        t.approve(address(s), amount);
        s.stake(amount);
        assertEq(t.balanceOf(address(this)), 0);
        assertEq(s.getAmount(address(this)), amount);
    }

    function testWithdrawBefor7Days(uint96 amount) public {
        uint totalSupply = t.totalSupply();
        vm.assume(amount <=  type(uint256).max - totalSupply && amount > 0);
        t.mint(address(this), amount);
        t.approve(address(s), amount);
        s.stake(amount);
        vm.expectRevert("cand withdraw befor 7 days");
        s.withdarw();
    }

    // function testWithdraw(uint96 amount) public {
    //     uint totalSupply = t.totalSupply();
    //     vm.assume(amount <=  type(uint256).max - totalSupply && amount > 0);
    //     uint amount = amount * 1e18;
    //     t.mint(address(this), amount);
    //     t.approve(address(s), amount);
    //     s.stake(amount);
    //     vm.warp(block.timestamp + 7 days);
    //     s.withdarw();
    //     assertEq(t.balanceOf(address(this)), amount + 20000 * 1e18 );
    // }



}
