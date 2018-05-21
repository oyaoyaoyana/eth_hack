import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'
import CreateAppointment from './views/CreateAppointment.vue'
import LastAppointment from './views/LastAppointment.vue'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/appointment/new',
      name: 'create_appointment',
      component: CreateAppointment
    },
    {
      path: '/appointment/last',
      name: 'last_appointment',
      component: LastAppointment
    },
    {
      path: '/',
      name: 'home',
      component: Home
    }
  ]
})
