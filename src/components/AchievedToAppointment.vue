<template>
  <div class="form">
    <ul v-if='status == "報告まだです。"'>
      <p>到着報告</p>
      <li><span>latitude</span><input v-model="latitude" type="number"></li>
      <li><span>longitude</span><input v-model="longitude" type="number"></li>
      <li><button @click="setAchievedToAppointment"type="button" name="button">到着報告する</button></li>
    </ul>
    <h2>{{status}}</h2>
    <p>{{message}}</p>
  </div>
</template>

<script>
export default {
  name: 'achieved-to-appointment',
  data() {
    return {
      id: 2,
      latitude: null,
      longitude: null,
      message: null,
      status: null
    }
  },
  created() {
    this.checkAchieved()
  },
  methods: {
    setAchievedToAppointment(){
      this.$store.state.contractInstance().setAchievedToAppointment(this.id, this.latitude, this.longitude, {
        from: this.$store.state.web3.coinbase
      })
      .then((r) => {
        this.message = "報告 done"
        this.checkAchieved()
      })
      .catch((e) => {
        console.log(e)
        this.message = "報告 faile"
      })
    },
    checkAchieved() {
      this.$store.state.contractInstance().userAcheivedToAppointment.call(this.$store.state.web3.coinbase, 1 )
      .then((r) => {
        if (r == true) {
          this.status = "報告済みです。"
        } else {
          this.status = "報告まだです。"
        }
      })
      .catch((e) => {
        console.log(e)
      })
    }
  }
}
</script>

<style lang="css">
</style>
