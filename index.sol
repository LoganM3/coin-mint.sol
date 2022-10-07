// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


contract CoinMinter{

    address public owner;
   
    mapping(address => uint) public balance;

    event Sent(address _from, address _to, uint _amount);

    error InsufficientBalance( uint _requested, uint _available);

    constructor(){
        owner = msg.sender;
    }

    function mint(address _receiver, uint _amount) public {
        require (msg.sender == owner);
        balance[_receiver] += _amount;   
    }

    function send(address _receiver, uint _amount) public {
        if(_amount > balance[msg.sender])
            revert InsufficientBalance({
                _requested: _amount,
                _available: balance[msg.sender]
            });

            balance[msg.sender] -= _amount;
            balance[_receiver] += _amount;
            emit Sent(msg.sender, _receiver, _amount);
    }

    function getBalance(address _account) external view returns(uint){
        return balance[_account];
    }
}