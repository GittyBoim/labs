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

    function testGetBalance() public {
        assertEq(w.getBalance(), 0);
    }

    function testDeposit() public {
        uint sum = 10000000;
        payable(address(w)).transfer(sum);
        assertEq(w.getBalance(), sum);
    }

    function addOwner() public{
        w.addOwner(address(1));
        assertEq(w.getCountOwners(), 1);
    }

   function testWithdraw() public {
       //uint sum = 100;
       //uint balance = 150;
       //payable(address(w)).transfer(balance);
       //w.withdraw(sum);
       //assertEq(w.getBalance(), balace - sum);
   }

   function testWithdrawWithoutEnoughMoney() public {
       uint sum = 50;
       uint balance = 10;
       payable(w).transfer(balance);
       vm.expectRevert();
       w.withdraw(sum);
   }
}
