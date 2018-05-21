<template >
</template>
<script>
export default {
  created() {
  },
  methods: {
    toSolTime(js_time){
      var beforeDate = js_time;
      beforeDate = beforeDate.split("-");
      var afterDate = beforeDate[1] + "/" + beforeDate[2] + "/" + beforeDate[0];
      sol_time = new Date(afterDate).getTime()
      return sol_time
    },
    fromSolTime(sol_time){
      var js_time = new Date(sol_time)
      return js_time
    }
  }
}
</script>
