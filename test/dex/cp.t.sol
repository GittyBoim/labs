// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/dex/cp.sol";
import "@hack/tokens/ERC20.sol";


contract cpTest is Test {

    CP cp; 
    MyToken token0;
    MyToken token1;

    function setUp() public {
        token0 = new MyToken();
        token1 = new MyToken();
        cp = new CP(address(token0), address(token1));
    }

    function testAddLiquidity() public {
        token0.mint(address(this), 10);
        token1.mint(address(this), 10);
        token0.approve(address(cp), 10);
        token1.approve(address(cp), 10);
        cp.addLiquidity(10, 10);
        assertEq(cp.balances(address(this)), 10);
    }

    function testRemoveLiquidity() public {
        token0.mint(address(this), 10);
        token1.mint(address(this), 10);
        token0.approve(address(cp), 10);
        token1.approve(address(cp), 10);
        cp.addLiquidity(10, 10);

        cp.removeLiquidity(5);
        assertEq(cp.balances(address(this)), 5);
        assertEq(token0.balanceOf(address(this)), 5);
        assertEq(token1.balanceOf(address(this)), 5);
    }

    function testSwap() public {
        token0.mint(address(this), 15 * 1e18);
        token1.mint(address(this), 10 * 1e18);
        token0.approve(address(cp), 15 * 1e18);
        token1.approve(address(cp), 10 * 1e18);
        cp.addLiquidity(10 * 1e18, 10 * 1e18);

        cp.swap(address(token0), 5 * 1e18);
        assertEq(token0.balanceOf(address(cp)), 15 * 1e18);
        assertEq(token1.balanceOf(address(this)), 3326659993326659993);
    }

    function testSwap1() public {
        token0.mint(address(this), 26 * 1e18);
        token1.mint(address(this), 42 * 1e18);
        token0.approve(address(cp), 26 * 1e18);
        token1.approve(address(cp), 42* 1e18);
        cp.addLiquidity(21 * 1e18, 42 * 1e18);

        cp.swap(address(token0), 5 * 1e18);
        assertEq(token0.balanceOf(address(cp)), 26 * 1e18);
        assertEq(token1.balanceOf(address(this)), 8057340773523186453);
        assertEq(token1.balanceOf(address(cp)), 33942659226476813547);
    }
}