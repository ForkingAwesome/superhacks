// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Organization} from "./Organization.sol";
import {OrganizationRegistry} from "./OrganizationRegistry.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract OrganizationFactory is Ownable {
    OrganizationRegistry public immutable i_organizationRegistry;

    constructor() Ownable(msg.sender) {
        i_organizationRegistry = new OrganizationRegistry(address(this));
    }

    function createOrganization(address _organizationAdmin) public {
        require(
            !i_organizationRegistry.isOrganizationOwner(msg.sender),
            "Address already an Owner"
        );

        Organization organization = new Organization(
            msg.sender,
            _organizationAdmin
        );
        i_organizationRegistry.addOrganization(organization);
    }

    // TO DO LATER
    function editOrganization(
        address _organizationAddress
    ) public onlyOrganizationOwner(_organizationAddress) {}

    function deleteOrganization(
        address _organizationAddress
    ) public onlyOrganizationOwner(_organizationAddress) {
        i_organizationRegistry.removeOrganization(
            Organization(_organizationAddress)
        );
    }

    modifier onlyOrganizationOwner(address _organizationAddress) {
        Organization organization = Organization(_organizationAddress);
        require(
            msg.sender == organization.getOwner(),
            "Caller is not authorized"
        );
        _;
    }
}
