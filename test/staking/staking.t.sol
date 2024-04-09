// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/staking/staking.sol";
import "@hack/staking/erc20.sol";

contract staking is Test {

    stakingContract s;
    MyToken immutable t;
    uint wad = 1000000000000000000;

    function setUp() public {
        t = new MyToken();
        s = new stakingContract(address(t));
    }

    function testMint() public {
        t.mint(address(this), 100);
        assertEq(t.balanceOf(address(this)), 100);
    }

    function testStake() public {
        t.mint(address(this), 100);
        t.approve(address(s), 100);
        s.stake(100);
        assertEq(t.balanceOf(address(this)), 0);
    }

    function testWithdrawBefor7Days() public {
        t.mint(address(this), 100);
        t.approve(address(s), 100);
        s.stake(100);
        vm.expectRevert("Cand withdraw befor 7 days");
        s.withdarw();
    }

    function testWithdraw() public {
        uint amount = 100 * wad;
        t.mint(address(this), amount);
        t.approve(address(s), amount);
        s.stake(amount);
        vm.warp(block.timestamp + 7 days);
        s.withdarw();
        assertEq(t.balanceOf(address(this)), amount + 1000000 * wad * 2 / 100);
        
    }
    
}