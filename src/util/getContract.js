import Web3 from 'web3'
import contract from 'truffle-contract'
import artifacts from '../../build/contracts/Areth.json'
const Areth = contract(artifacts)
Areth.setProvider(web3.currentProvider)
let getContract = Areth.deployed().then((i) => {
  return i
})

export default getContract
