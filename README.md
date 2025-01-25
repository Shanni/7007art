# AI Art NFT Contract

A smart contract implementation for minting and managing AI-generated artwork as NFTs, following the ERC7007 standard for AI-generated content.

## Overview

AiArtNFT is an ERC721-compliant smart contract that allows for:
- Minting NFTs with associated AI-generated artwork
- Storing and verifying AI generation proofs
- Managing artwork data and prompts on-chain

## Features

- ERC721 compliant NFT implementation
- Implementation of IERC7007 interface for AI-generated content
- Ownership management with OpenZeppelin's Ownable
- Secure minting with proof verification
- On-chain storage of AI generation data

## Contract Functions

### Core Functions

- `mintAiArt(address to, bytes prompt, bytes artData, bytes proof)`: Mint new AI artwork NFTs
- `addAigcData(uint256 tokenId, bytes prompt, bytes aigcData, bytes proof)`: Add or update AI generation data
- `verify(bytes prompt, bytes aigcData, bytes proof)`: Verify AI generation proof
- `getAiArtData(uint256 tokenId)`: Retrieve artwork data, prompts, and proofs

### Data Storage

The contract stores three key pieces of data for each token:
- Prompts used for generation
- AI-generated content data
- Generation proofs

## Usage

1. Deploy the contract:
2. Mint an NFT with a prompt
3. Add AI-generated content data and proof
4. Verify the data and proof
5. Retrieve the data and proof for any token

