<template>
  <div>
    <h1></h1>
    <show-appointment :last_id="last_id"></show-appointment>
    <achieved-to-appointment/>
  </div>
</template>

<script>
import ShowAppointment from '@/components/ShowAppointment';
import AchievedToAppointment from '@/components/AchievedToAppointment'
export default {
  name: 'last-appointment',
  components: {
    'show-appointment': ShowAppointment,
    'achieved-to-appointment': AchievedToAppointment
  },
  data() {
    return {
      user_count: 0,
      last_id: 2
    }
  },
  created() {
    var i;
    // this.get_apo_count()
  },
  methods: {
    // get_apo_count(){
    //   this.$store.state.contractInstance().userToAppointmentCount.call(this.$store.state.web3.coinbase)
    //   .then((r) => {
    //     this.user_count = r.toNumber()
    //   })
    //   .catch((e) => {
    //     console.log(e)
    //   })
    // },
    // set_apo_count(){
    //   // this.$store.state.contractInstance().getMyLastApointment.call(this.user_count)
    //   // .then((r) => {
    //   // })
    //   // .catch((e) => {
    //   //   console.log(e)
    //   // })
    // }
  },
  watch: {
    // user_count: function() {
    //   this.set_apo_count()
    // }
  }
    // this.$store.state.contractInstance().getMyLastApointment.call(this.$store.state.web3.coinbase)
    // .then((r) => {
    //   console.log(r)
    // })
    // .catch((e) => {
    //   console.log(e)
    // })
}
</script>

<style lang="css">
</style>
