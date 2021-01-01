// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

contract DmusicUser {
    bool public isExist=false;
    
    enum UserType {
        Customer,
        Artist
    }
    
    struct Product {
        uint productId;
        string productName;
    }
    
    mapping(uint => Product) public products;
    
    struct Customer {
        string customerName;
        bool isExist;
    }
    
    struct Artist {
        address artistAddress;
        string artistName;
        bool isExist;
    }
    
    mapping(address => Customer) public customerList;
    mapping(address => Artist) public artistList;
    
    function registerCustomer(string memory name) public {
        isExist = true;
        customerList[msg.sender] = Customer({
            customerName: name,
            isExist: isExist
        });
    }
    
    function registerArtist(string memory name) public {
        isExist = true;
        artistList[msg.sender] = Artist({
            artistAddress: msg.sender,
            artistName: name,
            isExist: isExist
        });
    }
    
    function getArtistDetail(address artistAddress) public view returns (Artist memory) {
        return artistList[artistAddress];
    }
    
    function getCustomerDetail(address customerAddress) public view returns (Customer memory) {
        return customerList[customerAddress];
    }
}


















