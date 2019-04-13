import Web3 from 'web3';

const getWeb3 = new Promise(function(resolve, reject) {
  // Wait for loading completion to avoid race conditions with web3 injection timing.
  window.addEventListener('load', async () => {
    var web3 = window.web3

    var provider = new Web3.providers.HttpProvider("http://localhost:8545")

    web3 = new Web3(provider)
    resolve({ instance: web3, isPresent: false })
  })
})

export default getWeb3
