<template>
  <div class="container">
    <p id="userInformation"></p>
    <button v-on:click="uportConnect" class="btn btn-sm btn-primary" id="connectUportBtn">Connect uPort</button>
    <p>{{this.message}}</p>
    <ul>
      <li>お名前：{{this.user.name}}</li>
      <li>母国：{{this.user.country}}</li>
      <li>ETHアドレス：{{this.user.address}}</li>
      <li>ID：{{this.user.id}}</li>
    </ul>
  </div>
</template>
<script>

var BASE58 = '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz'
var base58 = require('base-x')(BASE58)
var hex = require('base-x')('0123456789abcdef')
import { sha3_256 } from 'js-sha3'
import { Buffer } from 'buffer'

export default {
  name: 'login-component',
  data() {
    return {
      message: null,
      user: {
        name: null,
        address: null,
        country: null,
        id: null
      }
    }
  },
  mounted(){
  },
  methods: {
    // Uportにリクエストを送る。
    uportConnect: function(){
      const Connect = window.uportconnect.Connect
      const SimpleSigner = window.uportconnect.SimpleSigner
      const logelem = document.getElementById("userInformation")
      var uport = new Connect('Areth', {
        clientId: "2oef6yyqyCzUTeWmzD7BKW8KGRVR3oAziTm",
        // network: 'rinkeby or ropsten or kovan',
        network: 'rinkeby',
        signer: SimpleSigner("e96dba687ca6f154852f64575c4c604c313b69ff8bae6be7992036e6de80b185")
      })
      // Request credentials to login
      uport.requestCredentials({
        requested: ['name', 'phone', 'country'],
        notifications: true // We want this if we want to recieve credentials
      }).then((credentials) => {
        // Do something
        console.log(credentials);
        // logelem.innerHTML = JSON.stringify(credentials, null, "  ")
        // logelem.innerHTML = JSON.stringify(credentials, null, "  ")/
        this.setUserData(credentials);
        this.uportDecodeAddress(credentials.address);
      })
    },

    // UportのアドレスをETHのアドレスに変換
    uportDecodeAddress: function(uport_address){
      const data = Buffer.from(base58.decode(uport_address))
      const netLength = data.length - 24
      const version = data.slice(0, 1)
      const network = data.slice(1, netLength)
      const address = data.slice(netLength, 20 + netLength)
      const check = data.slice(netLength + 20)
      this.user.address = `0x${address.toString('hex')}`
      // web3のcoinbaseをmetamaskからuportに変更
      // this.$store.state.web3.coinbase = this.user.address
      this.createUser()
    },

    // Contract上にUser情報を登録
    createUser: function(){
      this.message = "会員登録開始";
      this.$store.state.contractInstance().createUser(this.user.address, {
        from: this.$store.state.web3.coinbase
      })
      .then((r) => {
        this.message = "会員登録完了"
        this.setUserId()
      })
      .catch((e) => {
        console.log(e)
        this.message = "会員登録開始失敗"
      })
    },
    setUserData: function(credentials){
      this.user.name = credentials.name
      this.user.country = credentials.country
    },
    setUserId: function(){
      this.user.id = 1;
    }
  }
}
</script>

<style lang="css">
</style>
