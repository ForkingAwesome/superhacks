// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {SubDAO} from "./interfaces/ISubDAO.sol";

contract Team is SubDAO {
    address[] private s_members;

    constructor(
        string memory _name,
        string memory _description,
        address _admin,
        address _ownerAddress
    ) SubDAO(_name, _description, _admin, _ownerAddress) {}
}
