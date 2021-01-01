// SPDX-License-Identifier: UNLICENSED 
pragma solidity ^0.6.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    constructor() ERC20("AndreCoin", "ADC") public {
        _setupDecimals(0);
        _mint(_msgSender(), 1000);
    }
}