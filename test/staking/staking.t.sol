// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/staking/staking.sol";
import "@hack/staking/erc20.sol";

contract staking is Test {

    stakingContract s;
    MyToken t;

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

    function testWithdraw() public {
        t.mint(address(this), 100);
        t.approve(address(s), 50);
        s.stake(50);
        assertEq(50, t.balanceOf(address(this)));
        vm.expectRevert("Cant withdraw before 7 days");
        s.withdarw();
    }

    
}