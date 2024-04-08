// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import "forge-std/interfaces/IERC20.sol";

contract MyToken is IERC20 {

    uint public totalSupply;

    mapping(address => uint)  public balanceOf;

    mapping (address=> mapping(address => uint)) public allowance;


    // function totalSupply() external view returns (uint256) {
    //     return totalSupply;
    // }

    // function balanceOf(address account) external view returns (uint256) {
    //     return balanceOf[account];
    // }

    function transfer(address to, uint256 amount) external returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        return true;
    }

    // function allowance(address owner, address spender) external view returns (uint256) {
    //     return allowance[owner][spender];
    // }

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
        return "Coin";
    }

    function decimals() external view returns (uint8) {
        return 1;
    }
    
    function mint(address to, uint amount) external {
        balanceOf[to] += amount;
        totalSupply += amount;
    }
}