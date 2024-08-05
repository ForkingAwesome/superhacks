// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {SubDAO} from "./interfaces/ISubDAO.sol";

contract Team is SubDAO {
    address[] private s_members;
    mapping(address => bool) private s_memberStatus;

    constructor(
        string memory _name,
        string memory _description,
        address _admin,
        address _ownerAddress,
        address _additionalAdminAddress
    )
        SubDAO(
            _name,
            _description,
            _admin,
            _ownerAddress,
            _additionalAdminAddress
        )
    {}

    function addMember(address _memberAddress) public onlyAuthorized {
        s_members.push(_memberAddress);
        s_memberStatus[_memberAddress] = true;
    }

    function removeMember(address _memberAddress) public onlyAuthorized {
        s_memberStatus[_memberAddress] = false;
    }

    function isMember(address _memberAddress) public view returns (bool) {
        return s_memberStatus[_memberAddress];
    }

    function getMembers() public view returns (address[] memory) {
        return s_members;
    }
}
