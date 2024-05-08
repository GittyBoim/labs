// // SPDX-License-Identifier: MIT
// pragma solidity >=0.6.12 <0.9.0;

// import "@hack/staking/erc20.sol";
// import "@hack/staking/staking.sol";

// contract userStaking {

//     MyToken token;
//     StakingContract staking;
//     constructor(MyToken _token, StakingContract _staking) public {
//         token = _token;
//         staking = _staking;
//     }

//     function doAprrove(address spender, uint sum) public {
//         token.approve(spender, sum);
//     }
//     function doTransfer(address to, uint amount) public {
//         token.transfer(to, amount);
//     }

//     function doStake() public {
//         staking.stake();
//     }

//     function doWithdraw() public {
//         staking.withdarw();
//     }
// }