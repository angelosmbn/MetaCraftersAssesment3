// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;


//For this project, write a smart contract that implements the require(), assert() and revert() statements.


contract ErrorHandling {
    string public name = "SampleToken";
    mapping(address => uint256) public balances;

    // Event for transfer
    event Transfer(address indexed from, address indexed to, uint256 amount);

    constructor() {
        // Assign initial balance to the contract creator
        balances[msg.sender] = 1000; // Starting balance of 1000 tokens
    }

    // Transfer tokens from sender to another address
    function transfer(address _to, uint256 _amount) public {
        // Ensure the sender has enough balance
        require(balances[msg.sender] >= _amount, "Not enough balance");

        // Ensure the recipient address is valid
        require(_to != address(0), "Invalid address");

        // Update balances
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;

        emit Transfer(msg.sender, _to, _amount);
    }

    // A function that demonstrates the use of assert()
    function checkBalanceInvariant() public view {
        // Invariant: The total balance must always be non-negative
        assert(balances[msg.sender] >= 0);
    }

    // A function that demonstrates the use of revert()
    function withdraw(uint256 _amount) public {
        // Check if the sender has enough balance to withdraw
        if (balances[msg.sender] < _amount) {
            revert("Insufficient balance for withdrawal");
        }

        balances[msg.sender] -= _amount; // Deduct balance
    }
}
