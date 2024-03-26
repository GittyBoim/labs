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

    function testdeposit(uint256 sum) public {
        vm.startPrank(vm.addr(1));
        vm.deal(vm.addr(1), sum);
        payable(address(w)).transfer(sum);
        assertEq(w.getBalance(), sum);
        vm.stopPrank();
    }

    function testWithdraw(uint256 sum) public {
        w.addOwner(vm.addr(1));
        vm.startPrank(vm.addr(1));
        payable(address(w)).transfer(sum);
        w.withdraw(sum);
        assertEq(w.getBalance(), sum);
        vm.stopPrank();
    }
}
