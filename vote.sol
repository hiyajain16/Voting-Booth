// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingBooth {
    mapping(string => uint256) public votes;
    mapping(address => bool) public hasVoted;
    string[] public candidates;

    function addCandidates(string[] memory _candidates) public {
        require(candidates.length == 0, "Candidates already set");
        candidates = _candidates;
    }

    function vote(string memory candidate) public {
        require(!hasVoted[msg.sender], "Already voted");
        bool validCandidate = false;
        for (uint i = 0; i < candidates.length; i++) {
            if (keccak256(abi.encodePacked(candidates[i])) == keccak256(abi.encodePacked(candidate))) {
                validCandidate = true;
                break;
            }
        }
        require(validCandidate, "Invalid candidate");
        votes[candidate]++;
        hasVoted[msg.sender] = true;
    }

    function getVotes(string memory candidate) public view returns (uint256) {
        return votes[candidate];
    }
}
