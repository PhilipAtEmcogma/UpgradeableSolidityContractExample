// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./Storage.sol";

// Example of Functional contract, not actual fully functional contract
//  but a contract use as an example on how to use proxy contract to update contracts

contract DogsUpdated is Storage{
    //create an modifier to restric access for some functions
    modifier onlyOwner(){
        require(msg.sender == owner);
        _; //if msg.sender is the owner continue to access the function
    }


    constructor() public{
        initialize(msg.sender);
    }

    function initialize(address _owner) public{
        //initialize variable of constructors
        require(_initialized);
        owner = _owner;
        _initialized = true;

    }

    //though _uintStorage from the Storage can't be change, the functions here can be updated
    function getNumberOgDogs() public view returns(uint256){
        return _uintStorage["Dogs"]; // return mapping
    }

    function setNumberOfDogs (uint256 toSet) public onlyOwner {
        _uintStorage["Dogs"] = toSet;
    }
}