// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/staking/staking.sol";
import "@hack/tokens/ERC20.sol";

contract staking is Test {

    StakingContract s;
    MyToken t;

    function setUp() public {
        t = new MyToken();
        s = new StakingContract(address(t));
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
        assertEq(s.getAmount(address(this)), 100);
    }

    function testWithdrawBefor7Days() public {
        t.mint(address(this), 100);
        t.approve(address(s), 100);
        s.stake(100);
        vm.expectRevert("cand withdraw befor 7 days");
        s.withdarw();
    }

    function testWithdraw() public {
        uint amount = 100 * 1e18;
        t.mint(address(this), amount);
        t.approve(address(s), amount);
        s.stake(amount);
        vm.warp(block.timestamp + 7 days);
        s.withdarw();
        assertEq(t.balanceOf(address(this)), amount + 20000 * 1e18 );
    }

    function testWithdraewWithTwoDeposist() public {
        uint amount1 = 150 * 1e18;
        address user1 = vm.addr(1);
        vm.startPrank(user1);
        t.mint(address(user1), amount1);
        t.approve(address(s), amount1);
        s.stake(amount1);
        vm.stopPrank();
        
        uint amount2 = 100 * 1e18;
        address user2 = vm.addr(2);  
        vm.startPrank(user2);
        t.mint(address(user2), amount2);
        t.approve(address(s), amount2);
        s.stake(amount2);
        vm.stopPrank();

        vm.startPrank(user1);
        vm.warp(block.timestamp + 7 days);
        s.withdarw();
        assertEq(t.balanceOf(address(user1)), amount1 + 12000 * 1e18);
        vm.stopPrank();

        vm.startPrank(user2);
        vm.warp(block.timestamp + 7 days);
        s.withdarw();
        assertEq(t.balanceOf(address(user2)), amount2 + 19760 * 1e18);
    }
    
}