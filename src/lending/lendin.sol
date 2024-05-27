// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import "@hack/tokens/MyIERC20.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

 struct borrow {
    uint collateral;
    uint borrow;
}

contract lending {

    address public owner;
    MyIERC20 bond;
    MyIERC20 dai;
    uint public minRatio;
    AggregatorV3Interface internal priceFeed;

    mapping(address => uint256) public daiDepositors;
    mapping(address => borrow) borrowers;

    constructor(address _bond, address _dai, uint minRatio) {
        owner = msg.sender;
        bond = MyIERC20(_bond);
        dai = MyIERC20(_dai);
        minRatio = _minRatio;
        priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
    } 

    modifier isOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    function provideLiquidity(uint amount) external {
        dai.transferFrom(msg.sender, address(this), amount);
        daiDepositors[msg.sender] += amount;
        bond.mint(msg.sender, amount);
    }

    //  איך לחשב את האחוזים זהוא אמור לקבל?
    function removeLiquidity(uint amount) external {
        require(daiDepositors[msg.sender] <= amount, "amount greater then the deposit");

        daiDepositors[msg.sender] -= amount;
        dai.transfer(msg.sender, amount);
        bond.burn(msg.sender, amount);
    }

    function addCollateral() payable external {
       borrowers[msg.sender].collateral += msg.value;
    }

    function removeCollateral(uint amount) external {
        require(getBorrowRatio(borrowers[msg.sender].collatreal - amount, borrowers[msg.sender].borrow) >= minRatio,
        "borrow ratio less than the min");

        borrowers[msg.sender].collateral -= amount;
        payable(msg.sender).transfer(amount);  
    }

    function requestBorrow(uint amount) external {
        require(getBorrowRatio(borrowers[msg.sender].collatreal, borrowers[msg.sender].borrow + amount) >= minRatio,
        "borrow ratio less than the min");

        borrowers[msg.sender].borrow += amount;
        dai.transfer(msg.sender, amount);
    }

    function repayBorrow(uint256 amount) external {
        require(borrowers[msg.sender] <= amount, "amout greater than the borrow amount");

        dai.transferFrom(msg.sender, address(this), amount);
        borrowers[msg.sender].borrow -= amount;
    }

    function getBorrowRatio(uint eth, uint dai) public view returns (uint) {
        (uint80 roundID, int256 price, uint256 startedAt, uint256 timeStamp, uint80 answeredInRound) =
            priceFeed.latestRoundData();
        return (uint(price)) ;
        return (price * eth * 1e18) / (dai * 1e8);
    }

    function discharge(address to) public isOwner {
        require(getBorrowRatio(borrowers[msg.sender].collateral, borrowers[msg.sender].borrow) < minRatio);

        //swap user eth - borrowers[to].collateral to dai

        borrowers[msg.sender] = 0;
        borrowers[msg.sender].collateral = 0;
    }

}




    



