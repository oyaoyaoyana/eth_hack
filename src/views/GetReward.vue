<template>
  <div class="get_reward">
    <p>ボタンを押して報酬を受け取ってください</p>
    <button v-on:click="getReward" class="btn btn-sm btn-primary" id="">報酬を受け取る</button>
    <p>現在の報酬</p>
    <p>{{this.balance}}</p>
    <p>{{this.advertisement}}</p>
  </div>
</template>

<script>
export default {
  name: 'get_reward',
  data(){
    return {
      balance: null,
      advertisement: null
    }
  },
  created(){
    var id = 1;
    // this.showAdvertisement(id)
    this.chargeEther()
  },
  methods:{
    // 広告をContractから取得するメソッド
    // showAdvertisement: function(id){
    //   this.$store.state.contractInstance().showAdvertisement(id, this.$store.state.web3.coinbase)
    //   .then((i) =>{
    //     this.appendAdvertisement(i)
    //   })
    //   .catch((e) => {
    //   })
    // },
    chargeEther: function(){
      this.$store.state.contractInstance().sendEther(this.$store.state.contractInstance().address, {from: this.$store.state.web3.coinbase})
      .then((i) => {
        this.updateBalance(balance)
      })
      .catch((e) => {
      })
    },
    // viewの広告を表示するメソッド
    appendAdvertisement: function(i){
      this.advertisement = i;
    },

    // Contractから広告をみた報酬を受け取るメソッド
    getReward: function(){
      this.$store.state.contractInstance().getReward({from: this.$store.state.web3.coinbase})
      .then((i) => {
        this.updateBalance(balance)
      })
      .catch((e) => {
      })
    },

    // 残高を更新するメソッド
    updateBalance: function(balance){
      this.balance += balance;
    }
  }
}
</script>

<style lang="css">
</style>
