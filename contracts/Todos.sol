//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.3;
pragma abicoder v2;

import "hardhat/console.sol";

contract Todos {
    uint256 todoId;
    address owner;

    struct Todo {        
        uint256 id;
        string description;
        bool finished;
    }

    mapping(uint256 => Todo) public todos;

    mapping(address => Todo[]) public todosByOwner;

    event TodoAdded(uint256, uint256[]);

    constructor() {
        owner = msg.sender;
        todoId = 0;
    }

    function getTodosByOwner() public view returns (Todo[] memory) {
        return todosByOwner[msg.sender];
    }

    //I don't NEED this getter- a public mapping created a getter for me. it just asks me to pass in the key as an argument for the method call.
    //* if I write a nested mapping, then I'll HAVE to pass in 1 argument for every mapping (each mapping's key)
    function getTodo(uint256 newId) public view returns (Todo memory) {
        return todos[newId];
    }

    function addTodo(string memory description) public payable {

        // I was treating mappings & arrays like JS objects and arrays.
            // 1) missed a separate getter (returning an array or mapping from a post methods a bad idea)
            // 2) was printing & accessing an object in my JS tesst file -- don't do that. access methods directly
            // 3) I was deploying without testing. bad, bad idea.
        Todo memory newTodo = Todo(todoId, description, false);
        todos[todoId] = newTodo;

        // todosByOwner[msg.sender].push(newTodo);

        todoId += 1;
    }

    function finishTodo(uint256 id) public returns (Todo memory) {
        require(todos[id].id == id, "You aren't the todo owner.");
        todos[id].finished = true;

        //CYCLE and update the ID-matching todo.
        // todosByOwner[msg.sender][id]finished = true;

        return todos[id];
    }

    ///remove todo --> do this later
    // function removeTodo() public {
    //     // require(todosByOwner[msg.sender].valid);

    // }
}