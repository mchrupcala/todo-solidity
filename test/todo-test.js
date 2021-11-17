const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Todos", function () {
  it("Should add a new todo", async function () {
    const Todos = await ethers.getContractFactory("Todos");
    const todos = await Todos.deploy();
    await todos.deployed();

    await todos.addTodo('description here it is');
    await todos.addTodo('Wash the dog');
    await todos.addTodo('Take a shower');
    
    const tx = await todos.getTodosById(2);

    expect(tx.description).to.equal("Take a shower");
    expect(tx.id).to.equal(2);
  });

  it("Should get all of senders todos", async function () {
    const [owner, acc1, acc2] = await ethers.getSigners();
    const Todos = await ethers.getContractFactory("Todos");
    const todos = await Todos.deploy();
    await todos.deployed();

    await todos.connect(owner).addTodo('description here it is');
    await todos.connect(owner).addTodo('Wash the dog');

    await todos.connect(acc1).addTodo('Write a book');
    await todos.connect(acc1).addTodo('Go to the gym');
    
                    //.connect will let me call the same method from different owners
    const tx = await todos.connect(owner).getTodos();
    const tx2 = await todos.connect(acc1).getTodos();
    console.log(tx);
    let strings = [];
    tx2.forEach(t => {
      strings.push(t.description);
    })

    expect(strings[0]).to.equal('Write a book');
    expect(strings[1]).to.equal('Go to the gym');
    expect(tx.length).to.equal(2);
  });
});
