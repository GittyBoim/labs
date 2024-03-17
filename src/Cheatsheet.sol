// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface  ITest {
    function payMe() external payable;
    
}

abstract contract Testbase {

    function nobody() external view virtual;

    //virtual without implemation must be override
    //pure - cant read or modify the state and the local variables of the contract
    //internal - only accessible within the current contract and contracts derived from it
    function _overrideMePlease(uint a) internal pure virtual  returns (uint) {   
        return a;
    }

    //external only accessible within other contract
    function overridableByStateVariable() external virtual returns (uint) {

    }

    // virtual modifier - can be overridden but not overloaded.
    modifier checker() virtual;

}


