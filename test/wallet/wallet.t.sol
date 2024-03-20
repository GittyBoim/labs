// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/wallet/wallet.sol";


contract WalletTest is Test {
    Wallet public w;

    // Everything I need to start my test
    function setUp() public {
        w = new Wallet();
    }

    function testDeposit() public {
        uint balance = w.getBalance();
        uint sum = 10000000;
        payable(address(w)).transfer(sum);
        assertEq(w.getBalance(), sum + balance);
    }

    function testAddOwner() public{
        w.addOwner(address(1));
        assertEq(w.countOwners(), 1);
        assertEq(w.owners(address(1)), true);
    }

    function testNotOwnerCantWithdraw() public {
        payable(address(w)).transfer(100);
        vm.expectRevert('Wallet not owner');
        vm.prank(address(1));
        w.withdraw(100);
    }

   function testWithdraw() public {
       uint sum = 100;
       uint balance = 150;
       payable(address(w)).transfer(balance);
       w.addOwner(vm.addr(1));
       vm.prank(vm.addr(1));
       w.withdraw(sum);
       //assertEq(w.getBalance(), balance - sum);
   }

   function testWithdrawWithoutEnoughMoney() public {
       uint sum = 50;
       uint balance = 10;
       payable(w).transfer(balance);
       vm.expectRevert();
       w.withdraw(sum);
   }
}
