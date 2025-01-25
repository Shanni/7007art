// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "../src/AiArtNFT.sol";

contract AiArtNFTTest is Test {
    AiArtNFT public nft;
    address owner = address(1);
    address user = address(2);

    function setUp() public {
        vm.prank(owner);
        nft = new AiArtNFT();
    }

    function testMintAiArt() public {
        bytes memory prompt = "A beautiful sunset";
        bytes memory artData = "ipfs://QmXXXXX";
        bytes memory proof = "signature";

        vm.prank(owner);
        uint256 tokenId = nft.mintAiArt(user, prompt, artData, proof);

        assertEq(nft.ownerOf(tokenId), user);
        
        (bytes memory storedPrompt, bytes memory storedArt, bytes memory storedProof) = nft.getAiArtData(tokenId);
        assertEq(keccak256(storedPrompt), keccak256(prompt));
        assertEq(keccak256(storedArt), keccak256(artData));
        assertEq(keccak256(storedProof), keccak256(proof));
    }
} 