// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface IERC7007 {
    event AigcData(
        uint256 indexed tokenId,
        bytes indexed prompt,
        bytes indexed aigcData,
        bytes proof
    );

    function addAigcData(
        uint256 tokenId,
        bytes calldata prompt,
        bytes calldata aigcData,
        bytes calldata proof
    ) external;

    function verify(
        bytes calldata prompt,
        bytes calldata aigcData,
        bytes calldata proof
    ) external view returns (bool success);
}

contract Humanoid7007 is ERC721, IERC7007, Ownable {
    // Mapping from token ID to its AIGC data
    mapping(uint256 => bytes) public prompts;
    mapping(uint256 => bytes) public aigcData;
    mapping(uint256 => bytes) public proofs;

    uint256 private _nextTokenId; // Track the next token ID

    // Pass msg.sender (or _msgSender()) to Ownable constructor
    constructor() ERC721("Humanoid7007", "H7007") Ownable(msg.sender) {
        // Initialize anything else here if needed
    }

    function mintAiArt(
        address to,
        bytes calldata prompt,
        bytes calldata artData,
        bytes calldata proof
    ) external onlyOwner returns (uint256) {
        require(verify(prompt, artData, proof), "Invalid AIGC proof");

        uint256 newTokenId = _nextTokenId;
        _nextTokenId++; // Increment the next token ID

        _mint(to, newTokenId);
        addAigcData(newTokenId, prompt, artData, proof);

        return newTokenId;
    }

    function addAigcData(
        uint256 tokenId,
        bytes calldata prompt,
        bytes calldata aigcData_,
        bytes calldata proof
    ) public override {
        require(_exists(tokenId), "Token does not exist"); 
        require(ownerOf(tokenId) == msg.sender || msg.sender == owner(), "Not authorized");

        prompts[tokenId] = prompt;
        aigcData[tokenId] = aigcData_;
        proofs[tokenId] = proof;

        emit AigcData(tokenId, prompt, aigcData_, proof);
    }

    function verify(
        bytes calldata prompt,
        bytes calldata aigcData_,
        bytes calldata proof
    ) public pure override returns (bool) {
        // Implement your verification logic here
        return true; // Placeholder
    }

    function getAiArtData(uint256 tokenId) 
        external 
        view 
        returns (
            bytes memory promptData,
            bytes memory artData,
            bytes memory proofData
        ) 
    {
        require(_exists(tokenId), "Token does not exist");
        return (prompts[tokenId], aigcData[tokenId], proofs[tokenId]);
    }

    /**
     * @dev Returns whether `tokenId` exists.
     * Tokens can be managed by their owner or approved accounts via {approve} or {setApprovalForAll}.
     */
    function _exists(uint256 tokenId) internal view virtual returns (bool) {
        return _ownerOf(tokenId) != address(0);
    }
}
