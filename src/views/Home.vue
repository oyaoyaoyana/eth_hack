<template>
  <div class="home">
    <TimeIsMoney/>
  </div>
</template>

<script>
// @ is an alias to /src
import TimeIsMoney from '@/components/TimeIsMoney.vue'

export default {
  name: 'home',
  components: {
    TimeIsMoney
  }
}
</script>
