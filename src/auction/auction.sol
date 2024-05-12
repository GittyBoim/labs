// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import "oz/ERC721/IERC721.sol";
import "forge-std/interfaces/IERC20.sol";


contract Auction {

    IERC721 NFT;
    IERC20 token;
    
    address owner;
    uint public tokenId;
    address seller;
    address public maxBidder;
    uint public maxBid;
    bool public start = false;
    uint public end;


    constructor() {
        owner = msg.sender;
    }

    modifier isOwner {
        require(msg.sender == owner, "only owner access");
        _;
    }

    function startAuction(address _NFT, uint _tokenId, address _token, uint initialBid, uint _end, address _seller) public isOwner {
        NFT = IERC721(_NFT);
        
        require(NFT.ownerOf(_tokenId) == _seller, "msg.sender not nft token owner");
        require(_end > block.timestamp, "invalid end date");
        require(!start, "Already there is auction");

        start = true;
        token = IERC20(_token);
        seller = msg.sender;
        tokenId = _tokenId;
        maxBid = initialBid;
        maxBidder = _seller;
        end = _end;

        NFT.transferFrom(seller, address(this), tokenId);  
    }

    function suggest(uint amount) public {
        require(start && block.timestamp < end, "Not active action");
        require(amount > maxBid, "the bid is lower than the max");

        token.transferFrom(msg.sender, address(this), amount);
        
        if(maxBidder != seller) {
            token.transfer(address(maxBidder), maxBid);
        }
        
        maxBid = amount;
        maxBidder = msg.sender;
    }

    function endAuction() public {
        require(block.timestamp > end, "auction not over");

        start = false;
        NFT.transferFrom(address(this), maxBidder, tokenId);
        token.transfer(seller, maxBid);
    }

}