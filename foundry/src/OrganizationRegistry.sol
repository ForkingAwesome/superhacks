// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Organization} from "./Organization.sol";

contract OrganizationRegistry {
    address[] public s_deployedOrganizations;
    address[] public s_organizationOwners;

    address public immutable i_authorizedFactory;

    mapping(address => bool) private s_organizationStatus;
    mapping(address => bool) private s_isOrganizationOwner;

    constructor(address _factory) {
        i_authorizedFactory = _factory;
    }

    function addOrganization(
        Organization _organization
    ) public onlyAuthorizedFactory {
        address organizationAddress = address(_organization);
        address organizationOwner = _organization.getOwner();

        s_deployedOrganizations.push(organizationAddress);
        s_organizationOwners.push(organizationOwner);
        s_organizationStatus[organizationAddress] = true;
        s_isOrganizationOwner[organizationOwner] = true;
    }

    function removeOrganization(
        Organization _organization
    ) public onlyAuthorizedFactory {
        address organizationAddress = address(_organization);
        address organizationOwner = _organization.getOwner();

        s_organizationStatus[organizationAddress] = false;
        s_isOrganizationOwner[organizationOwner] = false;
    }

    function getDeployedOrganizationsAddresses()
        public
        view
        returns (address[] memory)
    {
        return s_deployedOrganizations;
    }

    function getOrganizationOwners() public view returns (address[] memory) {
        return s_organizationOwners;
    }

    function isOrganizationActive(
        address _organizationAddress
    ) public view returns (bool) {
        return s_organizationStatus[_organizationAddress];
    }

    function isOrganizationOwner(
        address _ownerAddress
    ) public view returns (bool) {
        return s_isOrganizationOwner[_ownerAddress];
    }

    modifier onlyAuthorizedFactory() {
        require(msg.sender == i_authorizedFactory, "Caller is not authorized");
        _;
    }
}
