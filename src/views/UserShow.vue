<template>
  <div class="show_appointment">
    <p>私の情報</p>
    <div v-for="promise_id in promise_ids">
      <router-link :to=" promise_id "></router-link>
    </div>
    <p>userのアドレスは {{$route.params.address}}</p>
  </div>
</template>

<script>
export default {
  data() {
    return {
      promise_count: null,
      promise_ids: []
    }
  },
  created() {
  },
  methods: {
  }
}
</script>

<style lang="css">
</style>
