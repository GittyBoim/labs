// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/auction/auction.sol";
import "@hack/tokens/ERC721.sol";
import "@hack/tokens/ERC20.sol";

contract AuctionTest is Test {

    Auction a;
    MyNFT NFT;
    MyToken token;

    function setUp() public {
        a = new Auction();
        NFT = new MyNFT();
        token = new MyToken();
        NFT.mint(address(this), 1);
    }

    function testStartAuction() public {
        NFT.approve(address(a), 1);
        a.startAuction(address(NFT), 1, address(token), 10, block.timestamp + 7 days, address(this));

        assertEq(a.maxBid(), 10);
        assertEq(a.maxBidder(), address(this));
        assertEq(a.end(), block.timestamp + 7 days);
        assertEq(NFT.ownerOf(1), address(a));
    }

    function testSuggest() public {
        NFT.approve(address(a), 1);
        a.startAuction(address(NFT), 1, address(token), 10, block.timestamp + 7 days, address(this));

        token.mint(address(this), 100);
        token.approve(address(a), 20);
        a.suggest(20);

        assertEq(token.balanceOf(address(this)), 80);
        assertEq(a.maxBid(), 20);
        assertEq(a.maxBidder(), address(this));
    }

    function testSuggestSmallerThanMaxBid() public {
        NFT.approve(address(a), 1);
        a.startAuction(address(NFT), 1, address(token), 10, block.timestamp + 7 days, address(this));

        token.mint(address(this), 5);
        token.approve(address(a), 5);

        vm.expectRevert("the bid is lower than the max");
        a.suggest(5);
    }

    function testEndAuction() public {
        NFT.approve(address(a), 1);
        a.startAuction(address(NFT), 1, address(token), 10, block.timestamp + 7 days, address(this));

        address user = vm.addr(1);
        token.mint(address(user), 20);
        vm.startPrank(user);
        token.approve(address(a), 20);
        a.suggest(20);
        vm.stopPrank();

        vm.warp(block.timestamp + 8 days);
        a.endAuction();

        assertEq(NFT.ownerOf(1), address(user));
        assertEq(token.balanceOf(address(this)), 20);
    }

    function testEndAuctionBeforeEnd() public {
        NFT.approve(address(a), 1);
        a.startAuction(address(NFT), 1, address(token), 10, block.timestamp + 7 days, address(this));

        address user = vm.addr(1);
        token.mint(address(user), 20);
        vm.startPrank(user);
        token.approve(address(a), 20);
        a.suggest(20);
        vm.stopPrank();

        vm.warp(block.timestamp + 6 days);
        vm.expectRevert("auction not over");
        a.endAuction();
    }

}
