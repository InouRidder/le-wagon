const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const web3 = new Web3(ganache.provider());

const compiledEnergyUnit = require('../ethereum/build/EnergyUnit.json');

let accounts;

beforeEach(async () => {
  accounts = await web3.eth.getAccounts();

  energyUnit = await new web3.eth.Contract(JSON.parse(compiledEnergyUnit.interface))
    .deploy({ data: compiledEnergyUnit.bytecode, arguments: ["Hey!"] })
    .send({ from: accounts[0], gas: '1000000' })
});

describe('EnergyUnit', () => {
  it('deploys an energy unit', () => {
    assert.ok(energyUnit.options.address);
  });

  it('marks caller as the campaign manager', async () => {
    const manager = await energyUnit.methods.manager().call();
    assert.equal(accounts[0], manager);
  });

  it('allows certiQ to validate energy unit', async () => {
  });

  it('requires a minimum amount of kilowatt', async () => {
  });
});
