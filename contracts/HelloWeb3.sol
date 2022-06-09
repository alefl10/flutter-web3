// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract HelloWeb3 {
    string public getName;

    constructor() {
        getName = "Unknown";
    }

    function setName(string memory newName) public{
		getName = newName;
    }
}
