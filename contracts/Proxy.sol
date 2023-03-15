// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./Storage.sol";

//  Proxy contract are meant to point to differnt functional contract, such that it achieve update
//  Proxy contract are not meant to have all the functionalities, but just to point to the functional contract that holds them
contract Proxy is Storage{
    // it's ok to add state variables in proxy contract
    // can add more state variables in proxy, but not fuctional
    address currentAddress;

    constructor(address _currentAddress) public{
        currentAddress = _currentAddress;
    }

    function upgrade(address _newAddress) public{
        currentAddress = _newAddress;
    }

    //  fall-back function, its like a default function where if someone tries to call a function that doesn't
    //  exist in this contract, soliditiy will run this function instead
    function () payable external{
        address implementation = currentAddress;
        require(currentAddress != address(0));
        bytes memory data = msg.data;

        //solidity version of assembly
        // no ; to be used in assembly code
        assembly{
            //mload = saving data
            let result := delegatecall(gas, implementation, add(data, 0x20), mload(data), 0, 0)
            let size := returndatasize
            let ptr := mload(0x40)
            returndatacopy(ptr, 0, size)
            //using switch case as a if-else.  if result is false, revert. else save data
            switch result
            case 0 {revert(ptr, size)}
            default {return(prt, size)}

        }
    }
}