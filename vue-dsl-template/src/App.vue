<template>
  <div class="app">
    <div class="box"></div>
    <text>{{ msg }}</text>
    <div class="btn" @click="clickAction">事件按钮</div>
  </div>
</template>

<script>
export default {
  name: "App",
  components: {},
  data: function() {
    return {
      msg: "iOS集成Vue测试工程1",
    };
  },
  methods: {
    clickAction() {
      console.log("1111");
      this.msg = "iOS集成Vue测试工程,我被点击了一下";
    },
  },
};
</script>

<style>
html,
body {
  height: 100%;
}
.app {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.box {
  width: 100px;
  height: 100px;
  background-color: red;
  margin-bottom: 20px;
}
.btn {
  padding: 10 10 10 10;
  background-color: beige;
  margin-top: 30;
}
</style>
