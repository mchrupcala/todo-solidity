//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma abicoder v2;

contract Todo {
    uint256 todoId;
    address owner;

    struct Todo {
        string description;
        bool finished;
    }

    ///account => list of todos (stored by ID)
    mapping(address => mapping(uint256 => Todo)) todosByOwner;

    constructor() {
        owner = msg.sender;
        todoId = 0;
    }

    function addTodo(string memory description) public {
        todosByOwner[msg.sender][todoId] = Todo({
            description: description,
            finished: false
        });

        todoId += 1;
    }

    function finishTodo(uint256 id) public returns (Todo memory) {
        todosByOwner[msg.sender][id].finished = true;
        return todosByOwner[msg.sender][id];
    }

    ///remove todo --> do this later
    // function removeTodo() public {
    //     // require(todosByOwner[msg.sender].valid);

    // }
}