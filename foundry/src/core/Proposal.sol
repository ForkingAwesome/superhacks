// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Bytes32Utils} from "../utils/Bytes32Utils.sol";

enum ProposalStatus {
    OPEN,
    CLOSED
}

enum ProposalLevel {
    TOP,
    MID,
    BOTTOM
}

enum ProposalResult {
    ACCEPTED,
    NO_RESULT,
    REJECTED
}

contract Proposal {
    using Bytes32Utils for bytes32;
    using Bytes32Utils for string;

    bytes32 private immutable s_proposalTitle;
    bytes32 private immutable s_proposalDescription;
    ProposalLevel private immutable s_proposalLevel;
    ProposalStatus private s_proposalStatus = ProposalStatus.OPEN;
    ProposalResult private s_proposalResult;
    int256 private s_proposalVotes;

    constructor(
        string memory _proposalTitle,
        string memory _proposalDescription,
        ProposalLevel _proposalLevel
    ) {
        s_proposalTitle = _proposalTitle.stringToBytes32();
        s_proposalDescription = _proposalDescription.stringToBytes32();
        s_proposalLevel = _proposalLevel;
    }

    function voteOnProposal(bool _inFavor) public proposalNotClosed {
        if (_inFavor == true) {
            s_proposalVotes += 1;
        } else {
            s_proposalVotes -= 1;
        }
    }

    function closeProposal() internal {
        s_proposalStatus = ProposalStatus.CLOSED;
    }

    function calculateResult() internal {
        if (s_proposalVotes > 0) {
            s_proposalResult = ProposalResult.ACCEPTED;
        } else if (s_proposalVotes == 0) {
            s_proposalResult = ProposalResult.NO_RESULT;
        } else {
            s_proposalResult = ProposalResult.REJECTED;
        }
    }

    function calculateVotesAndCloseProposal() public proposalNotClosed {
        calculateResult();
        closeProposal();
    }

    function getProposalTitle() public view returns (string memory) {
        return s_proposalTitle.bytes32ToString();
    }

    function getProposalDescription() public view returns (string memory) {
        return s_proposalDescription.bytes32ToString();
    }

    function getProposalLevel() public view returns (ProposalLevel) {
        return s_proposalLevel;
    }

    function getProposalStatus() public view returns (ProposalStatus) {
        return s_proposalStatus;
    }

    modifier proposalNotClosed() {
        require(
            s_proposalStatus == ProposalStatus.OPEN,
            "This Proposal is Closed"
        );
        _;
    }
}
