// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import "forge-std/interfaces/IERC20.sol";

contract MyToken is IERC20 {

    uint public totalSupply;

    mapping(address => uint)  public balanceOf;

    mapping (address=> mapping(address => uint)) public allowance;
    
    address owner;

    uint totalOwnerMint;

    constructor() public {
        owner = msg.sender;
        totalOwnerMint = 0;
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external returns (bool) {
        allowance[from][msg.sender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
        return true;
    }

    function name() external view returns (string memory) {
        return "STK";
    }

    function symbol() external view returns (string memory) {
        return "STK";
    }

    function decimals() external view returns (uint8) {
        return 18;
    }
    
    function mint(address to, uint amount) external {
        balanceOf[to] += amount;
        totalSupply += amount;
    }
}