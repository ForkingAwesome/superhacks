// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {IWorldID} from "../worldcoin/interfaces/IWorldID.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Proposal, ProposalStatus} from "./Proposal.sol";

contract MainDAO is Ownable {
    error NotEnoughVotesToCloseProposal();
    error NotProposalOwner();

    address[] public s_subDaos;
    address[] public s_proposals;
    uint256 private s_totalMembers = 0;

    mapping(address => bool) private s_isSubDaoActive;

    IWorldID internal immutable worldId;

    event NewProposalCreated(string indexed title, string indexed description);
    event ProposalClosed(address proposalAddress);

    constructor(IWorldID _worldID) Ownable(msg.sender) {
        worldId = _worldID;
    }

    function createNewProposal(
        string memory _title,
        string memory _description,
        string memory _appId,
        string memory _actionId
    ) public {
        Proposal newProposal = new Proposal(
            msg.sender,
            _title,
            _description,
            worldId,
            _appId,
            _actionId
        );
        s_proposals.push(address(newProposal));

        emit NewProposalCreated(_title, _description);
    }

    function voteOnProposal(
        address _proposalAddress,
        bool _inFavor,
        address signal,
        uint256 root,
        uint256 nullifierHash,
        uint256[8] calldata proof
    ) public {
        Proposal proposal = Proposal(_proposalAddress);

        require(
            proposal.getProposalStatus() == ProposalStatus.OPEN,
            "Cannot vote on a closed proposal!"
        );

        proposal.voteOnProposal(_inFavor, signal, root, nullifierHash, proof);
    }

    function closeProposal(address _proposalAddress) public {
        Proposal proposal = Proposal(_proposalAddress);

        require(
            proposal.getProposalStatus() == ProposalStatus.OPEN,
            "The Proposal is already Closed"
        );

        address owner = proposal.getProposalCreator();

        if (msg.sender != owner) {
            revert NotProposalOwner();
        }

        uint256 totalVotes = proposal.getProposalVotesInFavor() +
            proposal.getProposalVotesAgainst();

        if (totalVotes < ((80 * s_totalMembers) / 100)) {
            revert NotEnoughVotesToCloseProposal();
        }

        proposal.calculateVotesAndCloseProposal(s_totalMembers);

        emit ProposalClosed(_proposalAddress);
    }
}
