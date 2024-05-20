// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;
import "@hack/tokens/ERC20.sol";
import "forge-std/console.sol";

contract Lending {

    struct usersToken {
        uint DAI;
        uint collateral;
        uint lending;
        uint borrow;
    }

    MyToken public tokenETH;
    MyToken public tokenDAI;
    MyToken public lendingToken;
    uint public daiValue;
    uint public borrowLimit;// גבול הלוואה
    uint public collateralValue; //ערך בטחונות
    uint public borrowedValue; //ערך שאול 
    uint public maxLTV;
    uint public borrowRate;//שיעור הלוואות
    mapping (address => usersToken) depositeUser;

    constructor(address _token1, address _token2, address _lendingToken) {
        tokenETH = new MyToken(_token1);
        tokenDAI = new MyToken(_token2);
        lendingToken = new MyToken(_lendingToken);
    }

    function deposit(uint amount) external {
        require(amount > 0,"amount is zero");
        tokenDAI.transferFrom(msg.sender, address(this), amount);
        lendingToken.mint(msg.sender,amount);
        daiValue += amount;
        lendingToken.transfer(msg.sender, amount);
        depositeUser[msg.sender].lending += amount;
    }

    function bornToken(uint amount) external {
        require(amount > 0,"amount is zero");
        require(amount <= depositeUser[msg.sender].lending, "you dont have engouh money in your account");
        lendingToken.born(msg.sender, amount);
        depositeUser[msg.sender].lending -= amount;
        tokenDAI.transfer(msg.sender,amount);
        depositeUser[msg.sender].DAI += amount;
        daiValue -= amount;
    }

    function addCollateral(uint amount) external {
        require(amount > 0,"amount is zero");
        tokenETH.transferFrom(msg.sender, address(this), amount);
        collateralValue += amount;
        depositeUser[msg.sender].collateral -= amount;
        tokenDAI.transfer(msg.sender,amount);
        depositeUser[msg.sender].DAI += amount;
    }

    function removeCollateral(uint amount) external {
        require(amount > 0,"amount is zero");
        require(depositeUser[msg.sender].collateral >= amount, "you dont have engouh collateral");
        tokenETH.transfer(msg.sender, amount);
        collateralValue -= amount;
        depositeUser[msg.sender].collateral -= amount;
    }

    function borrow(uint amount) external {
        require(amount > 0, "amount is zero");
        require(amount >= depositeUser[msg.sender].collateral, "you dont have engouh collateral");
        tokenDAI.transfer(msg.sender,amount );
        depositeUser[msg.sender].collateral -= amount;
        collateralValue -=amount;
    }
    
    // function returnDAI(uint amount) external {
    //     require(amount > 0,"amount is zero");
    //     require(amount <= user);
    // }
}