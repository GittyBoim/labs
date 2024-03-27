//spdx-license-Indetifier: Unlicense
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/wallet/wallet.sol";

contract WalletFuzzTest is Test {
    Wallet public w;

    function setUp() public {
        w = new Wallet();
    }

    function testAddOwner(address owner) public {
        w.addOwner(owner);
        assertEq(w.countOwners(), 1);
        assertEq(w.owners(owner), true);
    }

    function testAddMoreThanThreeOwners(address owner) public {
        w.addOwner(vm.addr(1));
        w.addOwner(vm.addr(2));
        w.addOwner(vm.addr(3));
        vm.expectRevert('There are already 3 owners cant add owner');
        w.addOwner(owner);
    }

    function  testDeleteOwner(address owner) public {
        w.addOwner(owner);
        assertEq(w.owners(owner), true);
        assertEq(w.countOwners(), 1);
        w.deleteOwner(owner);
        assertEq(w.owners(owner), false);
        assertEq(w.countOwners(), 0);
    }

    function testDeleteNotExistsUser(address owner) public  {
        vm.expectRevert('Owner not exists');
        w.deleteOwner(owner);
    }


    function testDeposit(uint256 sum, address owner) public {
        vm.prank(owner);
        vm.deal(owner, sum);
        payable(address(w)).transfer(sum);
        assertEq(w.getBalance(), sum);
    }

    function testWithdraw(address owner, uint256 sum) public {
        w.addOwner(owner);
        vm.deal(owner, sum);
        vm.startPrank(owner);
        payable(address(w)).transfer(sum);
        uint balance = w.getBalance();
        assertEq(balance, sum);
        //vm.startPrank(owner);
        w.withdraw(sum);
        vm.stopPrank();
        assertEq(w.getBalance(), balance -sum);
        //vm.deal(payable(address(w)), sum);
        //w.withdraw(sum);
        //assertEq(w.getBalance(), sum);
        //vm.stopPrank();
   }
}
