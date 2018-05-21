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
    <div v-if="apo"class="myLastApointment">
      <h2>here is apo</h2>
      <ul>
        <li>{{apo.id}}</li>
        <li>{{apo.owner}}</li>
        <li>{{apo.pricing}}</li>
        <li>{{apo.finished}}</li>
        <li>{{apo.etherMount}}</li>
      </ul>
    </div>
  </div>
</template>

<script>

export default {
  name: 'tim-component',
  data() {
    return {
      account: null,
      message: "Let's create new Appointment",
      pricing: 1,
      deadline: "2018-05-03",
      latitude: 100,
      longitude: 200,
      apo: {
        id: null,
        owner: null,
        etherMount: null,
        finished: null,
        pricing: null,
        deadline: null,
        latitude: null,
        longitude: null
      }
    }
  },
  mounted() {
    TimeIsMoney.setProvider(web3.currentProvider);
  },
  methods: {
    convertTimeType(){
      var beforeDate = this.deadline;
      beforeDate = beforeDate.split("-");
      var afterDate = beforeDate[1] + "/" + beforeDate[2] + "/" + beforeDate[0];
      this.deadline = new Date(afterDate).getTime()
    },
    createAppointment() {
      this.convertTimeType()
      this.message = "Transaction started";
      return TimeIsMoney.deployed()
      .then((instance) => instance.createPromise(this.deadline, this.latitude, this.longitude, {
        from: this.$store.state.web3.coinbase,
        value: this.$store.state.web3.web3Instance().toWei(this.pricing, 'ether')
        }))
      .then((r) => {
        this.message = "Transaction done"
      })
      .catch((e) => {
        console.log(e)
        this.message = "Transaction faile"
      })
    }
  }
}
</script>

<style lang="css">
li {
  list-style: none;
}
</style>
