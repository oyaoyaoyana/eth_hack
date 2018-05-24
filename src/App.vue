<template>
  <div id="app">
    <H1>MeetMe!</H1>
    <div id="nav">
      <router-link to="/appointment/new">新規アポ作成</router-link> |
      <router-link to="/appointment/last">最後のアポ</router-link> |
      <router-link to="/appointment/withdraw">アポから引き出す</router-link> |
    </div>
    <router-view/>
    <hello-metamask/>
  </div>
</template>
<script>
import HelloMetamask from '@/components/HelloMetamask'

export default {
  components: {
    'hello-metamask': HelloMetamask
  },
  beforeCreate () {
    console.log('registerWeb3 Action dispatched from meetme-dapp.vue')
    this.$store.dispatch('registerWeb3')
  }
}

</script>
<style lang="scss">
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  color: #2c3e50;
  padding: 30px;
}

#nav {
  a {
    font-weight: bold;
    color: #2c3e50;
    &.router-link-exact-active {
      color: #42b983;
    }
  }
}

</style>
