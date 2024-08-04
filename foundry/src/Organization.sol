// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @dev Organization is the top level DAO
 */
contract Organization is Ownable {
    constructor(address _owner) Ownable(_owner) {}

    function getOwner() public view returns (address) {
        return owner();
    }
}
