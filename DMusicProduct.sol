// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
import "./DmusicUser.sol";
import "./Token.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

// step to buy a product in remix IDE
// 1 approve
// 2 allowance

// 1. call approve function in token.sol
// 0x05898eB9924012c537B69b87DA3E91823ec4c899 DmusicProduct address
// put amount 20

// 2. call allowance in token.sol
// owner: 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB customer address
// spender: 0x05898eB9924012c537B69b87DA3E91823ec4c899

contract DmusicProduct is Ownable {
    
    Token token;
    DmusicUser dmusicUser;
    uint public productId=1;
    
    constructor(address userContract, Token _token) public {
        dmusicUser = DmusicUser(userContract);
        token = _token;
    }
        
    struct Product {
        uint productId;
        string productName;
        uint proudctPriceInADC;
        address artistAddress;
    }
    
    mapping(uint => Product) public products;
    mapping(address => uint[]) public customerProductPurchased; 
    mapping(address => uint[]) public artistProduct; 
    
    function addProduct(string memory productName, uint proudctPriceInADC) public {
        if (dmusicUser.getCustomerDetail(msg.sender).isExist) {
            revert("Only artist account can upload product!");
        }
        
        products[productId] = Product(productId, productName, proudctPriceInADC, msg.sender);
        artistProduct[msg.sender].push(productId);
        productId++;
    }
    
    function buyProduct(uint id) public {
        address artistAddress = dmusicUser.getArtistDetail(products[id].artistAddress).artistAddress;
        token.transferFrom(msg.sender, artistAddress, products[id].proudctPriceInADC * 90 / 100);
        token.transferFrom(msg.sender, Ownable.owner(), products[id].proudctPriceInADC * 10 / 100);
        customerProductPurchased[msg.sender].push(products[id].productId);
    }
    
    function getOwner() public view returns (address) {
        return Ownable.owner();
    }
}