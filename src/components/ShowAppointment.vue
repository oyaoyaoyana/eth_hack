<template>
  <ul>
    <li>id : {{this.apo.id}}</li>
    <li>owner : {{this.apo.owner}}</li>
    <li>meeting_time : {{this.apo.meeting_time}}</li>
    <li>etherAmount : {{this.apo.etherAmount}}</li>
    <li>pricing : {{this.apo.pricing}}</li>
    <li>finished : {{this.apo.finished}}</li>
    <li>latitude : {{this.apo.latitude}}</li>
    <li>longitude : {{this.apo.longitude}}</li>
  </ul>
</template>

<script>
import ConvertTimeType from '@/shared/ConvertTimeType'
export default {
  name: 'show-appointment',
  mixins: [
    ConvertTimeType
  ],
  data() {
    return {
      apo: {
        id: null,
        owner: null,
        meeting_time: null,
        etherAmount: null,
        pricing: null,
        finished: null,
        latitude: null,
        longitude: null
      }
    }
  },
  props: ['last_id'],
  beforeMount() {
    this.get_apo(this.last_id)
  },
  methods: {
    get_apo(last_id) {
      this.$store.state.contractInstance().getAppointment.call(last_id)
      .then((r) => {
        var apo = {}
        apo["id"] = r[0].toNumber()
        apo["owner"] = r[1]
        apo["meeting_time"] = this.fromSolTime(r[2].toNumber())
        apo["etherAmount"] = web3.fromWei(r[3].toNumber(), 'ether')
        apo["pricing"] = web3.fromWei(r[4].toNumber(), 'ether')
        apo["finished"] = r[5]
        apo["latitude"] = r[6].toNumber()
        apo["longitude"] = r[7].toNumber()
        console.log(r)
        this.set_apo(apo)
      })
      .catch((e) => {
        console.log(e)
      })
    },
    set_apo(apo) {
      this.apo = apo;
    },
    check_already_bet() {
      this.$store.state.contractInstance().userBetToAppointment.call()
    }
  }
}
</script>

<style lang="css">
li {
  list-style: none;
}
</style>
