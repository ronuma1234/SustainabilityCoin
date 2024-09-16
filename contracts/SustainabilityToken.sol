// contracts/SustainabilityToken.sol
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";  

contract SustainabilityToken is ERC20 {
    uint constant _initial_supply = 100 * (10**18);
    string sustainabilityProof;

    /* ERC 20 constructor takes in 2 strings, feel free to change the first string to the name of your token name, and the second string to the corresponding symbol for your custom token name */
    constructor() public ERC20("SustainabilityToken", "STC") {
        _mint(msg.sender, _initial_supply);
    }

    uint256 favoriteNumber;

    function testFunc1 (uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    function testFunc2() public view returns (uint256) {
        return favoriteNumber;
    }

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


    //Override the _update function in order to restrict transactions that connect to the UN sus goals

    
}