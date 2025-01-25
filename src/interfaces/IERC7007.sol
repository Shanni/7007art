// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

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
