<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <img class="dog" src="../assets/dog.png" />
  </div>
</template>

<script>
export default {
  name: "HelloWorld",
  props: {
    msg: String,
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.hello {
  display: flex;
  flex-direction: column;
  justify-self: start;
  align-items: center;
  width: 1000px;
}
.dog {
  width: 40%;
  height: 40%;
  border: 1px solid red;
  margin-left: 120px;
  margin-top: 20px;
}
</style>
