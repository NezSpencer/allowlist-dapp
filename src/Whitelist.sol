// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.24;

contract Whitelist {
    uint8 public maxWhitelistCount;
    uint8 whitelistCount;
    address ownerAddress;

    modifier onlyOwner {
        require(msg.sender == ownerAddress, "Unauthorized!");
        _;
    }

    mapping(address => bool) public whitelistedAddresses;

    constructor(uint8 maxWhitelist) {
        maxWhitelistCount = maxWhitelist;
        ownerAddress = msg.sender;
        whitelistedAddresses[msg.sender] = true;
        whitelistCount += 1;
    }

    function whitelistUser(address _user) public onlyOwner {
        addToWhitelist(_user);
    }

    function addToWhitelist(address _user) internal {
        require(!whitelistedAddresses[_user], "User has already been whitelisted!");
        require(whitelistCount + 1 <= maxWhitelistCount, "Sorry, Whitelist limit exceeded!");
        whitelistedAddresses[_user] = true;
        whitelistCount += 1;
    }

    function whitelist() external {
        addToWhitelist(msg.sender);
    } 

    function revokeWhitelist(address _user) public onlyOwner {
        bool isWhitelisted = whitelistedAddresses[_user];
        whitelistedAddresses[_user] = false;
        if(isWhitelisted) {
            whitelistCount -= 1;
        }
    }

    function checkWhitelistStatus() public view returns (bool) {
        return whitelistedAddresses[msg.sender];
    }

    function increaseWhitelistMax(uint8 newLimit) public onlyOwner {
        require(newLimit > maxWhitelistCount, "New limit has to be greater than the current max whitelist count");
        maxWhitelistCount = newLimit;
    }
}

