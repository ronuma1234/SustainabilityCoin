// contracts/DocumentVerifier.sol
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;


contract DocumentVerifier {
    struct Evidence {
        string title;
        string ipfsHash;
        address sender;
        address receiver;
        bool isTransferred;
        uint256 timestamp;
    }

    mapping(address => Evidence[]) private receivedPieces;
    mapping(address => Evidence[]) private sentPieces;

    event EvidenceSent(address indexed sender, address indexed receiver, string title, string ipfsHash, uint256 timestamp);

    function sendEvidence(address _receiver, string memory _title, string memory _ipfsHash) public {
        Evidence memory newEvidence = Evidence({
            title: _title,
            ipfsHash: _ipfsHash,
            sender: msg.sender,
            receiver: _receiver,
            isTransferred: true,
            timestamp: block.timestamp
        });

        receivedPieces[_receiver].push(newEvidence);
        sentPieces[msg.sender].push(newEvidence);

        emit EvidenceSent(msg.sender, _receiver, _title, _ipfsHash, block.timestamp);
    }

    function getReceivedEvidence() public view returns (Evidence[] memory) {
        return receivedPieces[msg.sender];
    }

    function getSentEvidence() public view returns (Evidence[] memory) {
        return sentPieces[msg.sender];
    }
}
