// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Bytes32Utils} from "../utils/Bytes32Utils.sol";
import {Project} from "./Project.sol";
import {Proposal, ProposalLevel} from "./Proposal.sol";

contract Organization is Ownable {
    using Bytes32Utils for bytes32;
    using Bytes32Utils for string;

    bytes32 private immutable i_name;
    bytes32 private immutable i_description;
    address[] private s_projects;
    address[] private s_proposals;
    mapping(address => bool) s_projectStatus;

    constructor(
        address _owner,
        string memory _name,
        string memory _description
    ) Ownable(_owner) {
        i_name = _name.stringToBytes32();
        i_description = _description.stringToBytes32();
    }

    function createProposal(
        string memory _title,
        string memory _description,
        ProposalLevel _level
    ) public {
        Proposal proposal;
        proposal = new Proposal(_title, _description, _level);
        s_proposals.push(address(proposal));
    }

    function createProject(
        string memory _name,
        string memory _description,
        address _adminAddress
    ) public onlyOwner {
        Project project = new Project(
            _name,
            _description,
            _adminAddress,
            owner(),
            _adminAddress
        );
        address projectAddress = address(project);

        s_projects.push(projectAddress);
        s_projectStatus[projectAddress] = true;
    }

    function deleteProject(address _projectAddress) public onlyOwner {
        s_projectStatus[_projectAddress] = false;
    }

    function getProposals() public view returns (address[] memory) {
        return s_proposals;
    }

    function getProjectStatus(
        address _projectAddress
    ) public view returns (bool) {
        return s_projectStatus[_projectAddress];
    }

    function getName() public view returns (string memory) {
        return i_name.bytes32ToString();
    }

    function getDescription() public view returns (string memory) {
        return i_description.bytes32ToString();
    }
}
