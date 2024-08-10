// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract SubDAO is Ownable {
    error SubDAOMemberAlreadyInactive();

    string private s_name;
    string private s_description;

    address[] private s_subDAOMembers;

    mapping(address => bool) private s_isSubDAOMemberActive;

    event SubDAONewMembersAdded(address[] indexed memberAddresses);
    event SubDAOMemberRemoved(address indexed memberAddress);

    constructor(
        address _subDAOOwnerAddress,
        string memory _name,
        string memory _description
    ) Ownable(_subDAOOwnerAddress) {
        s_name = _name;
        s_description = _description;
        s_subDAOMembers.push(_subDAOOwnerAddress);
        s_isSubDAOMemberActive[_subDAOOwnerAddress] = true;
    }

    function addMembersToSubDAO(
        address[] memory _memberAddresses
    ) public onlyOwner {
        for (uint i = 0; i < _memberAddresses.length; i++) {
            address memberAddress = _memberAddresses[i];

            s_subDAOMembers.push(memberAddress);
            s_isSubDAOMemberActive[memberAddress] = true;
        }

        emit SubDAONewMembersAdded(_memberAddresses);
    }

    function removeMemberFromSubDAO(
        address _subDAOMemberAddress
    ) public onlyOwner {
        if (!s_isSubDAOMemberActive[_subDAOMemberAddress]) {
            revert SubDAOMemberAlreadyInactive();
        }

        s_isSubDAOMemberActive[_subDAOMemberAddress] = false;

        emit SubDAOMemberRemoved(_subDAOMemberAddress);
    }

    function setNewSubDAOName(string memory _newName) public onlyOwner {
        s_name = _newName;
    }

    function setNewSubDAODescription(
        string memory _newDescription
    ) public onlyOwner {
        s_description = _newDescription;
    }

    function getSubDAOMemberStatus(
        address _subDAOMemberAddress
    ) public view returns (bool) {
        return s_isSubDAOMemberActive[_subDAOMemberAddress];
    }

    function getSubDAOName() public view returns (string memory) {
        return s_name;
    }

    function getSubDAODescription() public view returns (string memory) {
        return s_description;
    }
}
