// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title TokenB
/// @notice A simple ERC20 token with mint capability
contract TokenB is ERC20, Ownable {
    constructor(address initialOwner) ERC20("TokenB", "TKNB") Ownable(initialOwner) {}

    /// @notice Mint tokens to any address
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}
