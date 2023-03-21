// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MetaPass is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    
    Counters.Counter private _tokenIds;
    uint256 private constant MAX_SUPPLY = 10000;
    uint256 private constant MINT_PRICE = 10000000000000000; // 0.01 ETH
    uint256 private constant MINT_TIME = 72 hours;
    uint256 private _startMintTime;
    uint256 private _mintedTokens;

    constructor() ERC721("MetaPass", "MP") {
        _startMintTime = block.timestamp;
    }

    function mintToken(address recipient, string memory tokenURI) external payable {
        require(_startMintTime + MINT_TIME > block.timestamp, "Minting period has ended");
        require(msg.value == MINT_PRICE, "Incorrect Ether value sent");
        require(_mintedTokens < MAX_SUPPLY, "Token supply limit reached");

        _mintedTokens++;
        _safeMint(recipient, _mintedTokens);
        _setTokenURI(_mintedTokens, tokenURI);
    }

    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    function supportsInterface(bytes4 interfaceId) public view override returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}