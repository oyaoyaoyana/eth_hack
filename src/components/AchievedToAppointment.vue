<template >
  <div class="form">
    <h1>到着しました</h1>
    <ul>
      <li><span>latitude</span><input v-model="latitude" type="number"></li>
      <li><span>longitude</span><input v-model="longitude" type="number"></li>
      <li><button @click="setAchievedToAppointment"type="button" name="button">到着報告する</button></li>
    </ul>
    <p>{{message}}</p>
  </div>
</template>

<script>
export default {
  name: 'achieved-to-appointment',
  data() {
    return {
      id: 0,
      latitude: null,
      longitude: null,
      message: "報告まだ"
    }
  },
  methods: {
    setAchievedToAppointment(){
      this.$store.state.contractInstance().setAchievedToAppointment(this.id, this.latitude, this.longitude, {
        from: this.$store.state.web3.coinbase
      })
      .then((r) => {
        debugger;
        this.message = "報告 done"
      })
      .catch((e) => {
        debugger;
        console.log(e)
        this.message = "報告 faile"
      })
    }
  }
}
</script>

<style lang="css">
</style>
