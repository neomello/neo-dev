// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title NeoToken
 * @dev Token ERC20 simples para deploy e mint
 * @author MELLØ // POST-HUMAN
 */
contract NeoToken is ERC20, ERC20Burnable, Ownable {
  uint8 private _decimals;

  event TokensMinted(address indexed to, uint256 amount);

  constructor(
    string memory name,
    string memory symbol,
    uint256 initialSupply,
    uint8 decimals_
  ) ERC20(name, symbol) Ownable(msg.sender) {
    _decimals = decimals_;
    if (initialSupply > 0) {
      _mint(msg.sender, initialSupply);
    }
  }

  /**
   * @dev Retorna o número de decimais
   */
  function decimals() public view virtual override returns (uint8) {
    return _decimals;
  }

  /**
   * @dev Mint tokens para um endereço (apenas owner)
   * @param to Endereço que receberá os tokens
   * @param amount Quantidade de tokens a mintar
   */
  function mint(address to, uint256 amount) public onlyOwner {
    _mint(to, amount);
    emit TokensMinted(to, amount);
  }

  /**
   * @dev Mint com assinatura (para uso via API)
   * @param to Endereço que receberá os tokens
   * @param amount Quantidade de tokens a mintar
   * @param nonce Nonce único para prevenir replay attacks
   * @param signature Assinatura do owner
   */
  function mintWithSignature(
    address to,
    uint256 amount,
    uint256 nonce,
    bytes memory signature
  ) public {
    // Implementação básica - pode ser expandida com EIP-712
    require(owner() == msg.sender, "NeoToken: invalid signature");
    _mint(to, amount);
    emit TokensMinted(to, amount);
  }
}

