// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {IWorldID} from "../worldcoin/interfaces/IWorldID.sol";
import {WorldIDVerifier} from "../worldcoin/WorldIDVerifier.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Proposal is WorldIDVerifier {
    enum ProposalStatus {
        OPEN,
        CLOSED
    }

    enum ProposalResult {
        ACCEPTED,
        REJECTED
    }

    string private s_proposalTitle;
    string private s_proposalDescription;
    uint256 private s_proposalVotesInFavor = 0;
    uint256 private s_proposalVotesAgainst = 0;
    address private immutable s_proposalCreator;

    ProposalStatus private s_proposalStatus;
    ProposalResult private s_proposalResult;

    constructor(
        address _proposalCreator,
        string memory _proposalTitle,
        string memory _proposalDescription,
        IWorldID _worldId,
        string memory _appId,
        string memory _actionId
    ) WorldIDVerifier(_worldId, _appId, _actionId) {
        s_proposalTitle = _proposalTitle;
        s_proposalDescription = _proposalDescription;
        s_proposalStatus = ProposalStatus.OPEN;
        s_proposalCreator = _proposalCreator;
    }

    function voteOnProposal(
        bool _inFavor,
        address signal,
        uint256 root,
        uint256 nullifierHash,
        uint256[8] calldata proof
    ) public proposalNotClosed {
        verifyAndExecute(signal, root, nullifierHash, proof);
        if (_inFavor == true) {
            s_proposalVotesInFavor += 1;
        } else {
            s_proposalVotesAgainst += 1;
        }
    }

    function closeProposal() internal {
        s_proposalStatus = ProposalStatus.CLOSED;
    }

    function calculateResult(uint256 _totalMembers) internal {
        if (s_proposalVotesInFavor >= (_totalMembers / 2)) {
            s_proposalResult = ProposalResult.ACCEPTED;
        } else {
            s_proposalResult = ProposalResult.REJECTED;
        }
    }

    function calculateVotesAndCloseProposal(
        uint256 _totalMembers
    ) public proposalNotClosed {
        calculateResult(_totalMembers);
        closeProposal();
    }

    function getProposalVotesInFavor() public view returns (uint256) {
        return s_proposalVotesInFavor;
    }

    function getProposalVotesAgainst() public view returns (uint256) {
        return s_proposalVotesAgainst;
    }

    function getProposalCreator() public view returns (address) {
        return s_proposalCreator;
    }

    function getProposalTitle() public view returns (string memory) {
        return s_proposalTitle;
    }

    function getProposalDescription() public view returns (string memory) {
        return s_proposalDescription;
    }

    function getProposalStatus() public view returns (ProposalStatus) {
        return s_proposalStatus;
    }

    modifier proposalNotClosed() {
        require(
            getProposalStatus() == ProposalStatus.OPEN,
            "This Proposal is Closed"
        );
        _;
    }
}
