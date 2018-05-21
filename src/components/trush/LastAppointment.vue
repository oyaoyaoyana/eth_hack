<template>
  <h2>hoge</h2>
</template>

<script>
import Vue from 'vue'
export default {
  name: 'last-appointment',
  data() {
    return {
      account: null,
      message: "Let's create new Appointment",
      pricing: 1,
      deadline: "2018-05-03",
      latitude: 100,
      longitude: 200
    }
  },
  mounted() {
    TimeIsMoney.setProvider(web3.currentProvider);
    this.getMyLastApointment();
  }
}
</script>

<style lang="css">
li {
  list-style: none;
}
</style>
