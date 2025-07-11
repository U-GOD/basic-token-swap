# 🪙 Basic Token Swap – Fixed Rate ERC-20 Exchange

This project demonstrates a **simple fixed-rate token swap contract** using Solidity smart contracts. It allows swapping between two ERC-20 tokens without relying on external liquidity pools or oracles.

## 🚀 Overview

**BasicTokenSwap** enables users to exchange a specified amount of **Token A** for **Token B** at a constant rate set by the contract owner.

This project is intended as a **learning exercise** to understand:

- How ERC-20 tokens are transferred  
- How swap logic is implemented  
- How to handle contract ownership and withdrawals

## 📂 Contracts

### 1️⃣ TokenA.sol  
A mintable ERC-20 token representing the first asset.

- Inherits from OpenZeppelin ERC20 and Ownable  
- Constructor:
  - Name: `"TokenA"`  
  - Symbol: `"TKNA"`  
  - Initial supply: Minted to the deployer

### 2️⃣ TokenB.sol  
A mintable ERC-20 token representing the second asset.

- Inherits from OpenZeppelin ERC20 and Ownable  
- Constructor:
  - Name: `"TokenB"`  
  - Symbol: `"TKNB"`  
  - Initial supply: Minted to the deployer

### 3️⃣ BasicTokenSwap.sol  
The swap contract.

- Holds reserves of Token B  
- Lets users swap Token A in exchange for Token B  
- Owner can withdraw any tokens  

**Key Features:**

✅ Fixed exchange rate using `rateNumerator` and `rateDenominator`  
✅ ERC-20 token transfer and balance checks  
✅ Owner-controlled withdrawals

## 🛠️ Deployment Steps

1. **Deploy TokenA.sol**

   Constructor:  
   `name: "TokenA"`  
   `symbol: "TKNA"`  
   `initialSupply: any starting amount (e.g., 1,000,000 ether units)`

2. **Deploy TokenB.sol**

   Constructor:  
   `name: "TokenB"`  
   `symbol: "TKNB"`  
   `initialSupply: any starting amount`

3. **Deploy BasicTokenSwap.sol**

   Constructor:  
   `_tokenA`: Address of TokenA contract  
   `_tokenB`: Address of TokenB contract  
   `_rateNumerator`: e.g., 1  
   `_rateDenominator`: e.g., 1

4. **Fund the swap contract with Token B**

   Transfer some Token B to the swap contract so it can pay out swaps.

5. **Approve Token A spending**

   Users must approve the swap contract to spend their Token A:  
   `TokenA.approve(BasicTokenSwapAddress, amount)`

6. **Swap**

   Call:  
   `BasicTokenSwap.swap(amount)`  
   - Transfers `amount` Token A to the contract  
   - Sends the calculated amount of Token B to the user

## ✨ Example Deployed Contracts (zkSync Sepolia)

- **Token A:** `0x31cfD41242232C317E6C56E1Fba087739b4d9c9f`  
- **Token B:** `0x98eEb93b291Cac726e6eb6C0c07F9B461a8c6D7d`  
- **BasicTokenSwap:** `0x320FCdc720020816CdC1AeaB8E1829Ecf632f060`

## 📖 Learning Outcomes

By studying and deploying this project, you’ll understand:

- The basics of ERC-20 token contracts  
- How to write a swap function  
- How approvals and transfers work  
- The concept of fixed-rate exchanges  
- Why real liquidity and market demand are critical for value

## 📎 Resources

- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts)  
- [Solidity Documentation](https://docs.soliditylang.org)  
- [zkSync Testnet](https://era.zksync.io)

## 🪙 License

MIT License
