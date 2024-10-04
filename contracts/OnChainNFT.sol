// contracts/onChainNFT.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


import {Base64} from "./Base64.sol";

contract OnChainNFT is ERC721URIStorage, Ownable(msg.sender) {
    event Minted(uint256 tokenId);

    // Replace the Counters.Counter with a simple uint256 variable
    uint256 private _tokenIdCounter;

    constructor() ERC721("OnChainNFT", "ONC") {
        _tokenIdCounter = 1; // Initialize token ID counter to start at 1
    }

    /* Converts an SVG to Base64 string */
    function svgToImageURI(string memory svg)
        public
        pure
        returns (string memory)
    {
        string memory baseURL = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0naHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmcnIHdpZHRoPScxMDI0JyBoZWlnaHQ9JzEwMjQnPgogICAgICA8ZGVmcz48Y2xpcFBhdGggaWQ9J2EnPjxwYXRoIGQ9J00wIDBoMTAyNHYxMDI0SDB6Jy8+PC9jbGlwUGF0aD48L2RlZnM+CiAgICAgIDxnIGNsaXAtcGF0aD0ndXJsKCNhKSc+CiAgICAgICAgPHBhdGggZD0nTTAgMGgxMDI0djEwMjRIMHonLz4KICAgICAgICA8cGF0aCBmaWxsPScjZmZmJyBkPSdNMCAyNDFoMTAyNHYyMEgwek0wIDUwMmgxMDI0djIwSDB6TTAgNzYzaDEwMjR2MjBIMHonLz4KICAgICAgICA8cGF0aCBmaWxsPScjZmZmJyBkPSdNMjQxIDBoMjB2MTAyNGgtMjB6Jy8+CiAgICAgIDwvZz4KICAgIDwvc3ZnPg==";
        string memory svgBase64Encoded = Base64.encode(bytes(svg));
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }

    /* Generates a tokenURI using Base64 string as the image */
    function formatTokenURI(string memory imageURI)
        public
        pure
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name": "LCM ON-CHAINED", "description": "A simple SVG based on-chain NFT", "image": "data:image/svg+xml;base64,PHN2ZyB4bWxucz0naHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmcnIHdpZHRoPScxMDI0JyBoZWlnaHQ9JzEwMjQnPgogICAgICA8ZGVmcz48Y2xpcFBhdGggaWQ9J2EnPjxwYXRoIGQ9J00wIDBoMTAyNHYxMDI0SDB6Jy8+PC9jbGlwUGF0aD48L2RlZnM+CiAgICAgIDxnIGNsaXAtcGF0aD0ndXJsKCNhKSc+CiAgICAgICAgPHBhdGggZD0nTTAgMGgxMDI0djEwMjRIMHonLz4KICAgICAgICA8cGF0aCBmaWxsPScjZmZmJyBkPSdNMCAyNDFoMTAyNHYyMEgwek0wIDUwMmgxMDI0djIwSDB6TTAgNzYzaDEwMjR2MjBIMHonLz4KICAgICAgICA8cGF0aCBmaWxsPScjZmZmJyBkPSdNMjQxIDBoMjB2MTAyNGgtMjB6Jy8+CiAgICAgIDwvZz4KICAgIDwvc3ZnPg=="}'
                            )
                        )
                    )
                )
            );
    }

    /* Mints the token */
    function mint(string memory svg) public onlyOwner {
        string memory imageURI = svgToImageURI(svg);
        string memory tokenURI = formatTokenURI(imageURI);

        // Use _tokenIdCounter directly for the new token ID
        uint256 newItemId = _tokenIdCounter;

        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        emit Minted(newItemId);

        // Manually increment the token ID counter
        _tokenIdCounter++;
    }
}
