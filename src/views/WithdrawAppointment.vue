<template>
  <div class="withdraw-appointment">
    <withdraw-appointment/>
    <p v-if="apo_finished === true">約束の時間を過ぎています</p>
    <p v-else>約束の時間の前です</p>
  </div>
</template>

<script>
import WithdrawAppointment from '@/components/WithdrawAppointment'
export default {
  name: 'withdraw_appointment',
  data() {
    return {
      apo_finished: false
    }
  },
  components: {
    'withdraw-appointment': WithdrawAppointment
  },
  created() {
    debugger;
    this.$store.state.contractInstance().checkAppointmentAlreadyFinised.call(1)
    .then((r) => {
      if (r == true) {
        apo_finished: true
      } else {
        apo_finished: false
      }
      debugger;
    })
    .catch((e) => {
      debugger;
    })
  }
}
</script>

<style lang="css">
</style>
