// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import "oz/ERC721/ERC721.sol";

contract MyNFT is ERC721 {

    constructor() ERC721("NFT", "NFT"){}
    function mint(address to, uint id) public  {
        _mint(to, id);
    }
}