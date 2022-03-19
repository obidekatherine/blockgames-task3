// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract MetaNft is ERC721, Ownable {
    
    uint256 public mintPrice = 0.04 ether;
    uint256 public totalSupply;
    uint256 public maxSupply;
    mapping(address => uint256) public mintedWallets;

    constructor() payable ERC721("MetaNft", "ETA") {
        maxSupply = 3;
    }
    
    function SetMaxSupply(uint256 maxSupply_) external onlyOwner {
        maxSupply = maxSupply_;
    }

    function safeMint(address to) public payable {
        //convert 0.04eth to wei and input the value before minting
        require(msg.value == mintPrice, "mint price is 0.04 eth");
        require(mintedWallets[to] < 3, "max supply exceeded");
        require(maxSupply > totalSupply, "sold out");

        mintedWallets[to]++;
        totalSupply++;
        uint256 tokenId = totalSupply;
        _safeMint(to, tokenId);
    }

  
}