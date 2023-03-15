// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// use to store all the variables for the functional contract
//  this contract will not be change, any updates will be updated via the functional contract
//  otherwise it will corrupt the proxy storage
//  therefore, need to carefully design what kind of storage is needed for the project / contract
contract Storage{
    //use mappings to store all types of data, such that it can be utilise in the future if needed.
    /*
        Example of using one of the mapping as storage of different things of a particular data type (uint)
        It's like key-value pair
            _uintStorage["Numer"] = 10;
            _uintStorage["NumberOfCats] = 200;
    */
    mapping (string => uint256) _uintStorage;
    mapping (string => address) _addressStorage;
    mapping (string => bool) _boolStorage;
    mapping (string => string) _stringStorage;
    address public owner;
    bool public _initialized;


}