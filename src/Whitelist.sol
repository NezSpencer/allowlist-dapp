// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.25;

contract Whitelist {
    uint8 public maxWhitelistCount;
    uint8 whitelistCount;

    mapping(address => bool) public whitelistedAddresses;

    constructor(uint8 maxWhitelist) {
        maxWhitelistCount = maxWhitelist;
    }

    function addToWhitelist() public {
        require(!whitelistedAddresses[msg.sender], "User has already been whitelisted!");
        require(whitelistCount + 1 <= maxWhitelistCount, "Sorry, Whitelist limit exceeded!");
        whitelistedAddresses[msg.sender] = true;
        whitelistCount += 1;
    }
}

