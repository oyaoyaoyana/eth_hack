import Vue from 'vue'
import App from './App.vue'
import router from './router'
import ElementUI from 'element-ui'
import { store } from './store/'

Vue.config.productionTip = false

new Vue({
  router,
  store,
  ElementUI,
  render: h => h(App)
}).$mount('#app')
