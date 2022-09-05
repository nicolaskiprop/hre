//SPDX_License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

//main building block for smart contracts
contract Token {
    string public name = "simba coin";
    string public symbol = "SMB";

    //fixed amount of tokens, stored in an unsigned integer type variable
    uint256 public totalSupply = 1000000;

    //address to store ethereum accounts
    address public owner;

    //a mapping is a key/value map. here we store each accounts balance
    mapping(address => uint256) balances;

    //the transfer event helps off-chain applications understand what happens within your contract
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    //contact initialization

    constructor() {
        //the total supply is assigned to the transaction sender, which is the account that is deploying the contract
        balances[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    //function to transfer tokens
    //the `external` modifier makes a function only callable from outside the contract

    function transfer(address to, uint256 amount) external {
        //check if the transaction sender has enough tokens.
        //If `require` first argument evaluates to `false` then the transaction will revert
        require(balances[msg.sender] >= amount, "Not enough tokens");

        //transfer the amount
        balances[msg.sender] -= amount;
        balances[to] += amount;

        //Notify off-chain applications of the transfer
        emit Transfer(msg.sender, to, amount);
    }

    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }
}
