// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/distribute/distribute.sol";


contract distribute is Test {
    distributeContract public d;

    function setUp() public {
        d = new distributeContract();
    }

    function testDistributeContract() public {
        address user1 = vm.addr(1);
        address user2 = vm.addr(2);
        address user3 = vm.addr(3);

        d.addUser(user1);
        d.addUser(user2);
        d.addUser(user3);

        d.distribute{value: 0}();

        assertEq(user1.balance, 0);
        assertEq(user2.balance, 0);
        assertEq(user3.balance, 0);
        
    }

}
