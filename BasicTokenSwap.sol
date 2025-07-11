// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Import the ERC-20 interface so we can call transfer, transferFrom, etc.
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// Import Ownable so only the contract owner can change settings
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title BasicTokenSwap
/// @notice Swaps between two ERC-20 tokens at a fixed rate
contract BasicTokenSwap is Ownable {
    // The token users will swap FROM
    IERC20 public tokenA;

    // The token users will swap TO
    IERC20 public tokenB;

    // Exchange rate numerator (e.g., 2 means 2/1 = 2 tokens out per 1 token in)
    uint256 public rateNumerator;

    // Exchange rate denominator
    uint256 public rateDenominator;

    /// @notice Constructor sets token addresses and fixed rate
    /// @param _tokenA Address of the token to swap from
    /// @param _tokenB Address of the token to swap to
    /// @param _rateNumerator Numerator of the exchange rate
    /// @param _rateDenominator Denominator of the exchange rate
    constructor(
        address _tokenA,
        address _tokenB,
        uint256 _rateNumerator,
        uint256 _rateDenominator
    ) Ownable(msg.sender) {
        require(_tokenA != address(0), "Invalid TokenA address");
        require(_tokenB != address(0), "Invalid TokenB address");
        require(_rateDenominator > 0, "Denominator cannot be zero");

        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
        rateNumerator = _rateNumerator;
        rateDenominator = _rateDenominator;
    }

    /// @notice Swap a specific amount of Token A for Token B
    /// @param amountIn The amount of Token A to swap
    function swap(uint256 amountIn) external {
        require(amountIn > 0, "Amount must be > 0");

        // Calculate how much Token B to send to the user
        uint256 amountOut = (amountIn * rateNumerator) / rateDenominator;

        require(amountOut > 0, "Amount out must be > 0");

        // Check the contract has enough Token B to complete the swap
        uint256 contractBalance = tokenB.balanceOf(address(this));
        require(contractBalance >= amountOut, "Not enough Token B liquidity");

        // Transfer Token A from the user to the contract
        bool received = tokenA.transferFrom(msg.sender, address(this), amountIn);
        require(received, "Token A transfer failed");

        // Transfer Token B from the contract to the user
        bool sent = tokenB.transfer(msg.sender, amountOut);
        require(sent, "Token B transfer failed");
    }

    /// @notice Owner can withdraw any token from the contract
    /// @param token Address of the token to withdraw
    /// @param to Address to receive the withdrawn tokens
    /// @param amount Amount of tokens to withdraw
    function withdraw(
        address token,
        address to,
        uint256 amount
    ) external onlyOwner {
        require(to != address(0), "Invalid recipient");
        require(amount > 0, "Amount must be > 0");

        bool success = IERC20(token).transfer(to, amount);
        require(success, "Withdraw transfer failed");
    }
}
