//SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import "@hack/tokens/ERC20.sol";
import "forge-std/console.sol";

contract Dex {

    IERC20 public immutable A;
    IERC20 public immutable B;
    address public owner;
    uint public balanceA;
    uint public balanceB;
    uint public totalSupply;
    mapping(address => uint) public balances;



    constructor(address _A, address _B) public {
        A = IERC20(_A);
        B = IERC20(_B);
        owner = msg.sender;
        totalSupply = 0;
    }

    function addLiquidity(uint amountA, uint amountB) public {
        require(totalSupply == 0 || (amountA * 1e18) / balanceA == (amountB * 1e18) / balanceB, "cant liquidity diffrent value");

        A.transferFrom(msg.sender, address(this), amountA);
        B.transferFrom(msg.sender, address(this), amountB);


        if(totalSupply == 0) {
            balances[msg.sender] = 10;
            totalSupply = 10;
        } else {
            balances[msg.sender] += (amountA * totalSupply) / balanceA;
            totalSupply += (amountA * totalSupply) / balanceA;
        }

        balanceA = A.balanceOf(address(this));
        balanceB = B.balanceOf(address(this));
        
    }

// מכאן - לבדוק wad
    function removeLiquidity(uint shares) public {
        require(shares > 0, "shares <= 0");
        require(balances[msg.sender] >= shares, "not enough balance");

        balances[msg.sender] -= shares;

        A.transfer(msg.sender, (shares * balanceA) / totalSupply);
        B.transfer(msg.sender, (shares * balanceB) / totalSupply);

        totalSupply -= shares;

        balanceA = A.balanceOf(address(this));
        balanceB = B.balanceOf(address(this));
    }

    function tradeAToB(uint amountA) public {
        uint currentTotal = balanceA * balanceB;
        balanceA += amountA;
        uint amountB = balanceB - (currentTotal / balanceA);
        balanceB -= amountB;
        A.transferFrom(msg.sender, address(this), amountA);
        B.transfer(msg.sender, amountB);
    }

    function tradeBToA(uint amountB) public {
        uint currnetToatal = balanceA * balanceB;
        balanceB += amountB;
        uint amountA =  balanceA - (currnetToatal / balanceB);
        balanceA -= amountA;
        B.transferFrom(msg.sender, address(this), amountB);
        A.transfer(msg.sender, amountA);
    }

    function priceA() public view returns(uint) {
        return (balanceB * 1e18) / balanceA;
    }

    function priceB() public view returns(uint) {
        return (balanceA * 1e18) / balanceB;
    }

}