// SPDX-License-Identifier: MIT
// pragma solidity >=0.6.12 <0.9.0;

// import "@hack/toekns/erc20.sol";

// contract Dex {

//     IERC20 public immutable A;
//     IERC20 public immutable B;
//     address public owner;
//     uint public balanceA;
//     uint public balanceB;
//     uint totalSupply;
//     mapping(address => uint) public balances;



//     constructor(uint initialA, uint initialB, address _A, address _B) public {
//         A = IERC20(_A);
//         B = IERC20(_B);
//         owner = msg.sender;
//         balanceA = initialA;
//         balanceB = initialB;
//         totalSupply = 1;
//     }

//     function addLiquidity(uint amountA, uint amountB) public {
//         require(amountA / balanceA == amountB / balanceB, "cant liquidity diffrent value");

//         A.transferFrom(msg.sender, address(this), amountA);
//         B.transferFrom(msg.sender, address(this), amountB);

//         balanceA = A.balanceOf(address(this));
//         balanceB = B.balanceOf(address(this));

//         balances[msg.sender] += amountA/balanceA * totalSupply;

//     }

//     function removeLiquidity(uint shares) public {
//         require(shares > 0);

//         A.transfer(msg.sender, (shares * balanceA) / totalSupply);
//         B.transfer(msg.sender, (shares * balanceB) / totalSupply);

//         totalSupply -= shares;
//         balances[msg.sender] -= shares;

//         balanceA = A.balanceOf(address(this));
//         balanceB = B.balanceOf(address(this));

//     }

//     function tradeAToB(uint amountA) public {
//         uint currentTotal = balanceA * balanceB;
//         balanceA += amountA;
//         uint amountB = balanceB - (currentTotal / balanceA);
//         balanceB -= amountB;
//         A.transferFrom(msg.sender, address(this), amountA);
//         B.transfer(msg.sender, amountB);
//     }

//     function tradeBToA(uint amountB) public {
//         uint currnetToatal = balanceA * balanceB;
//         balanceB += amountB;
//         uint amountA =  balanceA - (currnetToatal / balanceB);
//         balanceA -= amountA;
//         B.transferFrom(msg.sender, address(this), amountB);
//         A.transfer(msg.sender, amountA);
//     }

//     function priceA() public view returns(uint) {
//         return balanceB / balanceA;
//     }

//     function priceB() public view returns(uint) {
//         return balanceA / balanceB;
//     }





// }