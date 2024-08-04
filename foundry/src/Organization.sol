// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

/**
 * @dev Organization is the top level DAO
 */
contract Organization {
    address private immutable i_owner;
    address private s_admin;

    constructor(address _owner, address _admin) {
        i_owner = _owner; // Sets the Person who created the Organization as the Owner

        if (_admin != address(0)) {
            s_admin = _admin;
        }
    }

    function getAdmin() public view returns (address) {
        return s_admin;
    }

    function getOwner() public view returns (address) {
        return i_owner;
    }
}
