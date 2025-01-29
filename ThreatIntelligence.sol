// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ThreatIntelligence {
    struct Threat {
        string hash;
        string threatType;
        string description;
        string ipfsHash;
        address submitter;
    }

    Threat[] public threats;
    mapping(string => bool) public hashExists;

    event ThreatSubmitted(uint256 id, string hash, string threatType, address submitter);

    function submitThreat(
        string memory _hash,
        string memory _threatType,
        string memory _description,
        string memory _ipfsHash
    ) public {
        require(!hashExists[_hash], "Threat with this hash already exists");
        threats.push(Threat(_hash, _threatType, _description, _ipfsHash, msg.sender));
        hashExists[_hash] = true;
        emit ThreatSubmitted(threats.length - 1, _hash, _threatType, msg.sender);
    }

    function getThreat(uint256 _id) public view returns (
        string memory hash,
        string memory threatType,
        string memory description,
        string memory ipfsHash,
        address submitter
    ) {
        Threat memory threat = threats[_id];
        return (threat.hash, threat.threatType, threat.description, threat.ipfsHash, threat.submitter);
    }

    function getThreatCount() public view returns (uint256) {
        return threats.length;
    }
}
