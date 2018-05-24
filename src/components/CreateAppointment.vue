<template>
  <div>
    <div class="form">
      <h1>Apoを作成する！</h1>
      <ul>
        <li><span>pricing</span><input v-model="pricing" type="number"></li>
        <li><span>meeting_time</span><input v-model="meeting_time" type="date"></li>
        <el-date-picker v-model="datetime" type="datetime" placeholder="日時を選択してください"></el-date-picker>
        <li><span>latitude</span><input v-model="latitude" type="number"></li>
        <li><span>longitude</span><input v-model="longitude" type="number"></li>
        <li><button @click="createAppointment"type="button" name="button">作成する</button></li>
      </ul>
    </div>
    <div class="message" v-if="message">{{message}}</div>
  </div>
</template>

<script>

export default {
  name: 'create-appointment',
  data() {
    return {
      account: null,
      message: "Let's create new Appointment",
      pricing: 1,
      meeting_time: "2018-05-03",
      latitude: 100,
      longitude: 200
    }
  },
  mounted() {
  },
  methods: {
    convertTimeType(meeting_time){
      var beforeDate = meeting_time;
      beforeDate = beforeDate.split("-");
      var afterDate = beforeDate[1] + "/" + beforeDate[2] + "/" + beforeDate[0];
      return new Date(afterDate).getTime()
    },
    createAppointment() {
      this.meeting_time = this.convertTimeType(this.meeting_time)
      this.message = "Transaction started";
      debugger;
      this.$store.state.contractInstance().createAppointment(1527144020, this.latitude, this.longitude, {
        from: this.$store.state.web3.coinbase,
        value: web3.toWei(this.pricing, 'ether')
      })
      .then((r) => {
        this.message = "Transaction done"
      })
      .catch((e) => {
        console.log(e)
        this.message = "Transaction faile"
      })
    }
  },
  watch() {

  }
}
</script>

<style lang="css">
li {
  list-style: none;
}
</style>
