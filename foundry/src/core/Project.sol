// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {SubDAO} from "../interfaces/ISubDAO.sol";
import {Team} from "./Team.sol";

contract Project is SubDAO {
    address[] private s_teams;
    mapping(address => bool) s_teamStatus;

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

    function createTeam(
        string memory _name,
        string memory _description,
        address _admin
    ) public onlyAuthorized {
        Team team = new Team(_name, _description, _admin, owner(), getAdmin());
        address teamAddress = address(team);

        s_teams.push(teamAddress);
        s_teamStatus[teamAddress] = true;
    }

    function deleteTeam(address _teamAddress) public onlyAuthorized {
        s_teamStatus[_teamAddress] = false;
    }

    function isTeamActive(address _teamAddress) public view returns (bool) {
        return s_teamStatus[_teamAddress];
    }

    function getTeams() public view returns (address[] memory) {
        return s_teams;
    }
}
