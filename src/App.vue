<template>
  <div id="app">
    <H1>ADRETH</H1>
    <div id="nav">
      <router-link to="">ユーザー情報</router-link> |
      <router-link to="/reward">報酬を受け取る</router-link> |
    </div>
    <router-view/>
    <hello-metamask/>
    <login-component/>
  </div>
</template>
<script>
import HelloMetamask from '@/components/HelloMetamask'
import LoginComponent from '@/components/LoginComponent'

export default {
  components: {
    'hello-metamask': HelloMetamask,
    'login-component': LoginComponent
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
