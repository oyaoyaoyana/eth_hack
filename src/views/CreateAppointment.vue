<template>
  <div>
    <create-appointment/>
  </div>
</template>

<script>
import CreateAppointment from '@/components/CreateAppointment'

export default {
  name: 'create_appointment',
  components: {
    'create-appointment': CreateAppointment
  },
  created() {
  }
}
</script>

<style lang="css">
</style>
