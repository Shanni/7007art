// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

interface IOpmlLib {
    function initOpmlRequest(bytes calldata prompt) external returns (uint256 requestId);
    function uploadResult(uint256 requestId, bytes calldata result) external;
    function getOutput(uint256 requestId) external view returns (bytes memory output);
    function isFinalized(uint256 requestId) external view returns (bool);
}
