// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/**
 * @title NeoNFT
 * @dev NFT ERC721 com suporte a IPFS para metadados
 * @author MELLØ // POST-HUMAN
 */
contract NeoNFT is ERC721, ERC721URIStorage, Ownable {
  using Counters for Counters.Counter;

  Counters.Counter private _tokenIdCounter;
  string private _baseTokenURI;

  event NFTMinted(address indexed to, uint256 indexed tokenId, string tokenURI);

  constructor(
    string memory name,
    string memory symbol,
    string memory baseTokenURI
  ) ERC721(name, symbol) Ownable(msg.sender) {
    _baseTokenURI = baseTokenURI;
  }

  /**
   * @dev Mint NFT para um endereço
   * @param to Endereço que receberá o NFT
   * @param tokenURI URI do token (pode ser IPFS)
   */
  function mint(address to, string memory tokenURI) public onlyOwner returns (uint256) {
    _tokenIdCounter.increment();
    uint256 tokenId = _tokenIdCounter.current();

    _safeMint(to, tokenId);
    _setTokenURI(tokenId, tokenURI);

    emit NFTMinted(to, tokenId, tokenURI);
    return tokenId;
  }

  /**
   * @dev Mint NFT com metadados IPFS
   * @param to Endereço que receberá o NFT
   * @param ipfsHash Hash IPFS dos metadados
   */
  function mintWithIPFS(address to, string memory ipfsHash) public onlyOwner returns (uint256) {
    string memory tokenURI = string(abi.encodePacked("ipfs://", ipfsHash));
    return mint(to, tokenURI);
  }

  /**
   * @dev Atualiza a base URI
   */
  function setBaseURI(string memory baseURI) public onlyOwner {
    _baseTokenURI = baseURI;
  }

  /**
   * @dev Retorna a base URI
   */
  function _baseURI() internal view override returns (string memory) {
    return _baseTokenURI;
  }

  /**
   * @dev Override necessário para ERC721URIStorage
   */
  function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
    return super.tokenURI(tokenId);
  }

  /**
   * @dev Override necessário para ERC721URIStorage
   */
  function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721URIStorage) returns (bool) {
    return super.supportsInterface(interfaceId);
  }
}

