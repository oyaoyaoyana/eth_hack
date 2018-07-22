import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'
import UserShow from './views/UserShow.vue'
import GetReward from './views/GetReward.vue'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home
    },
    {
      path: '/user/:address',
      name: 'user_show',
      component: UserShow
    },
    {
      path: '/reward',
      name: 'get_reward',
      component: GetReward
    }
  ]
})
