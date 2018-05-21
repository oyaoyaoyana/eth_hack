import Web3 from 'web3'
import contract from 'truffle-contract'
import artifacts from '../../build/contracts/MeetMe.json'
const MeetMe = contract(artifacts)
MeetMe.setProvider(web3.currentProvider)
let getContract = MeetMe.deployed().then((i) => {
  return i
})

export default getContract
