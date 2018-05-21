<template>
  <div>
    <tim-component/>
    <hello-metamask/>
  </div>
</template>

<script>

import HelloMetamask from '@/components/hello-metamask'
import TimComponent from '@/components/tim-component'
import web3 from 'web3'

export default {
  name: 'TimeIsMoney',
  components: {
    'hello-metamask': HelloMetamask,
    'tim-component': TimComponent
  }
}
</script>

<style lang="css">
</style>
