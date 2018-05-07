<template>
  <div>
    <div class="form">
      <h1>Create New Appointment</h1>
      <ul>
        <li><span>pricing</span><input v-model="pricing" type="number"></li>
        <li><span>deadline</span><input v-model="deadline" type="date"></li>
        <li><span>latitude</span><input v-model="latitude" type="number"></li>
        <li><span>longitude</span><input v-model="longitude" type="number"></li>
        <li><button @click="createAppointment"type="button" name="button">作成する</button></li>
      </ul>
    </div>
    <div class="message" v-if="message">{{message}}</div>
  </div>
</template>

<script>
import web3 from 'web3'
import contract from 'truffle-contract'
import artifacts from '../../build/contracts/TimeIsMoney.json'
const TimeIsMoney = contract(artifacts)
export default {
  name: 'TimeIsMoney',
  data() {
    return {
      message: "Let's create new Appointment",
      pricing: null,
      deadline: null,
      latitude: null,
      longitude: null
    }
  },
  created() {
    if (web3.currentProvider !== undefined) {
      console.warn("Using web3 detected from external source. If you find that your accounts don't appear or you have 0 Fluyd, ensure you've configured that source properly. If using MetaMask, see the following link. Feel free to delete this warning. :) http://truffleframework.com/tutorials/truffle-and-metamask")
      // Use Mist/MetaMask's provider
      web3 = new Web3(web3.currentProvider)
    } else {
      console.warn("No web3 detected. Falling back to http://127.0.0.1:8545. You should remove this fallback when you deploy live, as it's inherently insecure. Consider switching to Metamask for development. More info here: http://truffleframework.com/tutorials/truffle-and-metamask")
      // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
      web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:8545"))
    }

    TimeIsMoney.setProvider(web3.currentProvider)
    web3.eth.getAccounts((err, accs) => {
      if (err != null) {
        console.error(err)
        this.message = "There was an error fetching your accounts. Do you have Metamask, Mist installed or an Ethereum node running? If not, you might want to look into that"
        return
      }
      if (accs.length == 0) {
        this.message = "Couldn't get any accounts! Make sure your Ethereum client is configured correctly."
        return
      }
      this.account = accs[0];
      TimeIsMoney.deployed()
        .then((instance) => instance.address)
        .then((address) => {
          this.contractAddress = address
        })
    })
  },
  methods: {
    createAppointment() {
      this.message = "Transaction started";
      return TimeIsMoney.deployed()
        .then((instance) => instance.createPromise(this.deadline, this.latitude, this.longitude, {from: this.account, value: this.pricing}));
    }
  }
}
</script>

<style lang="css">
li {
  list-style: none;
}
</style>
