// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/dex/dex.sol";
import "@hack/tokens/ERC20.sol";


contract DexTest is Test {

    Dex dex; 
    MyToken A;
    MyToken B;

    function setUp() public {
        A = new MyToken();
        B = new MyToken();
        dex = new Dex(address(A), address(B));
    }

    function testAddLiqidity() public {
        A.mint(address(this), 10 * 1e18);
        B.mint(address(this), 10 * 1e18);
        A.approve(address(dex), 10 * 1e18);
        B.approve(address(dex), 10 * 1e18);
        dex.addLiquidity(10 * 1e18, 10 * 1e18);
        assertEq(dex.balances(address(this)), 10);

        A.mint(address(this), 9 * 1e18);
        B.mint(address(this), 9 * 1e18);
        A.approve(address(dex), 9 * 1e18);
        B.approve(address(dex), 9 * 1e18);
        console.log("before", dex.totalSupply());
        dex.addLiquidity(9 * 1e18, 9 * 1e18);
        console.log("jh", dex.totalSupply());
        assertEq(dex.balances(address(this)), 19);
    }

    function testRemoveLiquidity() public {
        A.mint(address(this), 10);
        B.mint(address(this), 10);
        A.approve(address(dex), 10);
        B.approve(address(dex), 10);
        dex.addLiquidity(10, 10);

        dex.removeLiquidity(5);
        assertEq(dex.balances(address(this)), 5);
        assertEq(A.balanceOf(address(this)), 5);
        assertEq(B.balanceOf(address(this)), 5);
    }

    // function testSwap() public {
    //     A.mint(address(this), 15 * 1e18);
    //     B.mint(address(this), 10 * 1e18);
    //     A.approve(address(dex), 15 * 1e18);
    //     B.approve(address(dex), 10 * 1e18);
    //     dex.addLiquidity(10 * 1e18, 10 * 1e18);

    //     dex.swap(address(A), 5 * 1e18);
    //     assertEq(A.balanceOf(address(dex)), 15 * 1e18);
    //     assertEq(B.balanceOf(address(this)), 3326659993326659993);
    //     console.log("B", B.balanceOf(address(this)));
    // }
}