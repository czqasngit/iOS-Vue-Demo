// { "framework": "Vue"}

/******/ (function(modules) { // webpackBootstrap
/******/     // The module cache
/******/     var installedModules = {};
/******/
/******/     // The require function
/******/     function __webpack_require__(moduleId) {
/******/
/******/         // Check if module is in cache
/******/         if(installedModules[moduleId]) {
/******/             return installedModules[moduleId].exports;
/******/         }
/******/         // Create a new module (and put it into the cache)
/******/         var module = installedModules[moduleId] = {
/******/             i: moduleId,
/******/             l: false,
/******/             exports: {}
/******/         };
/******/
/******/         // Execute the module function
/******/         modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/         // Flag the module as loaded
/******/         module.l = true;
/******/
/******/         // Return the exports of the module
/******/         return module.exports;
/******/     }
/******/
/******/
/******/     // expose the modules object (__webpack_modules__)
/******/     __webpack_require__.m = modules;
/******/
/******/     // expose the module cache
/******/     __webpack_require__.c = installedModules;
/******/
/******/     // define getter function for harmony exports
/******/     __webpack_require__.d = function(exports, name, getter) {
/******/         if(!__webpack_require__.o(exports, name)) {
/******/             Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/         }
/******/     };
/******/
/******/     // define __esModule on exports
/******/     __webpack_require__.r = function(exports) {
/******/         if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/             Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/         }
/******/         Object.defineProperty(exports, '__esModule', { value: true });
/******/     };
/******/
/******/     // create a fake namespace object
/******/     // mode & 1: value is a module id, require it
/******/     // mode & 2: merge all properties of value into the ns
/******/     // mode & 4: return value when already ns object
/******/     // mode & 8|1: behave like require
/******/     __webpack_require__.t = function(value, mode) {
/******/         if(mode & 1) value = __webpack_require__(value);
/******/         if(mode & 8) return value;
/******/         if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/         var ns = Object.create(null);
/******/         __webpack_require__.r(ns);
/******/         Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/         if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/         return ns;
/******/     };
/******/
/******/     // getDefaultExport function for compatibility with non-harmony modules
/******/     __webpack_require__.n = function(module) {
/******/         var getter = module && module.__esModule ?
/******/             function getDefault() { return module['default']; } :
/******/             function getModuleExports() { return module; };
/******/         __webpack_require__.d(getter, 'a', getter);
/******/         return getter;
/******/     };
/******/
/******/     // Object.prototype.hasOwnProperty.call
/******/     __webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/     // __webpack_public_path__
/******/     __webpack_require__.p = "";
/******/
/******/
/******/     // Load entry module and return exports
/******/     return __webpack_require__(__webpack_require__.s = "./src/main.wx.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./node_modules/weex-vue-loader/lib/script-loader.js!./node_modules/weex-vue-loader/lib/selector.js?type=script&index=0!./src/App.vue":
/*!********************************************************************************************************************************************!*\
  !*** ./node_modules/weex-vue-loader/lib/script-loader.js!./node_modules/weex-vue-loader/lib/selector.js?type=script&index=0!./src/App.vue ***!
  \********************************************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n//\n//\n//\n//\n//\n//\n//\n//\n\n/* harmony default export */ __webpack_exports__[\"default\"] = ({\n  name: \"App\",\n  components: {},\n  data: function() {\n    return {\n      msg: \"iOS集成Vue测试工程1\",\n    };\n  },\n  methods: {\n    clickAction() {\n      console.log(\"1111\");\n      this.msg = \"iOS集成Vue测试工程,我被点击了一下\";\n    },\n  },\n});\n\n\n//# sourceURL=webpack:///./src/App.vue?./node_modules/weex-vue-loader/lib/script-loader.js!./node_modules/weex-vue-loader/lib/selector.js?type=script&index=0");

/***/ }),

/***/ "./node_modules/weex-vue-loader/lib/style-loader.js!./node_modules/weex-vue-loader/lib/style-rewriter.js?id=data-v-7ba5bd90!./node_modules/weex-vue-loader/lib/selector.js?type=styles&index=0!./src/App.vue":
/*!*******************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/weex-vue-loader/lib/style-loader.js!./node_modules/weex-vue-loader/lib/style-rewriter.js?id=data-v-7ba5bd90!./node_modules/weex-vue-loader/lib/selector.js?type=styles&index=0!./src/App.vue ***!
  \*******************************************************************************************************************************************************************************************************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("module.exports = {\n  \"app\": {\n    \"display\": \"flex\",\n    \"flexDirection\": \"column\",\n    \"justifyContent\": \"center\",\n    \"alignItems\": \"center\"\n  },\n  \"box\": {\n    \"width\": \"100\",\n    \"height\": \"100\",\n    \"backgroundColor\": \"#FF0000\",\n    \"marginBottom\": \"20\"\n  },\n  \"btn\": {\n    \"paddingTop\": 10,\n    \"paddingRight\": 10,\n    \"paddingBottom\": 10,\n    \"paddingLeft\": 10,\n    \"backgroundColor\": \"#F5F5DC\",\n    \"marginTop\": 30\n  }\n}\n\n//# sourceURL=webpack:///./src/App.vue?./node_modules/weex-vue-loader/lib/style-loader.js!./node_modules/weex-vue-loader/lib/style-rewriter.js?id=data-v-7ba5bd90!./node_modules/weex-vue-loader/lib/selector.js?type=styles&index=0");

/***/ }),

/***/ "./node_modules/weex-vue-loader/lib/template-compiler.js?id=data-v-7ba5bd90!./node_modules/weex-vue-loader/lib/selector.js?type=template&index=0!./src/App.vue":
/*!*********************************************************************************************************************************************************************!*\
  !*** ./node_modules/weex-vue-loader/lib/template-compiler.js?id=data-v-7ba5bd90!./node_modules/weex-vue-loader/lib/selector.js?type=template&index=0!./src/App.vue ***!
  \*********************************************************************************************************************************************************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("module.exports={render:function (){var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;\n  return _c('div', {\n    staticClass: [\"app\"]\n  }, [_c('div', {\n    staticClass: [\"box\"]\n  }), _c('text', [_vm._v(_vm._s(_vm.msg))]), _c('div', {\n    staticClass: [\"btn\"],\n    on: {\n      \"click\": _vm.clickAction\n    }\n  }, [_vm._v(\"事件按钮\")])])\n},staticRenderFns: []}\nmodule.exports.render._withStripped = true\n\n//# sourceURL=webpack:///./src/App.vue?./node_modules/weex-vue-loader/lib/template-compiler.js?id=data-v-7ba5bd90!./node_modules/weex-vue-loader/lib/selector.js?type=template&index=0");

/***/ }),

/***/ "./src/App.vue":
/*!*********************!*\
  !*** ./src/App.vue ***!
  \*********************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("var __vue_exports__, __vue_options__\nvar __vue_styles__ = []\n\n/* styles */\n__vue_styles__.push(__webpack_require__(/*! !../node_modules/weex-vue-loader/lib/style-loader!../node_modules/weex-vue-loader/lib/style-rewriter?id=data-v-7ba5bd90!../node_modules/weex-vue-loader/lib/selector?type=styles&index=0!./App.vue */ \"./node_modules/weex-vue-loader/lib/style-loader.js!./node_modules/weex-vue-loader/lib/style-rewriter.js?id=data-v-7ba5bd90!./node_modules/weex-vue-loader/lib/selector.js?type=styles&index=0!./src/App.vue\")\n)\n\n/* script */\n__vue_exports__ = __webpack_require__(/*! !../node_modules/weex-vue-loader/lib/script-loader!../node_modules/weex-vue-loader/lib/selector?type=script&index=0!./App.vue */ \"./node_modules/weex-vue-loader/lib/script-loader.js!./node_modules/weex-vue-loader/lib/selector.js?type=script&index=0!./src/App.vue\")\n\n/* template */\nvar __vue_template__ = __webpack_require__(/*! !../node_modules/weex-vue-loader/lib/template-compiler?id=data-v-7ba5bd90!../node_modules/weex-vue-loader/lib/selector?type=template&index=0!./App.vue */ \"./node_modules/weex-vue-loader/lib/template-compiler.js?id=data-v-7ba5bd90!./node_modules/weex-vue-loader/lib/selector.js?type=template&index=0!./src/App.vue\")\n__vue_options__ = __vue_exports__ = __vue_exports__ || {}\nif (\n  typeof __vue_exports__.default === \"object\" ||\n  typeof __vue_exports__.default === \"function\"\n) {\nif (Object.keys(__vue_exports__).some(function (key) { return key !== \"default\" && key !== \"__esModule\" })) {console.error(\"named exports are not supported in *.vue files.\")}\n__vue_options__ = __vue_exports__ = __vue_exports__.default\n}\nif (typeof __vue_options__ === \"function\") {\n  __vue_options__ = __vue_options__.options\n}\n__vue_options__.__file = \"/Volumes/Work/dev/vue-mobile/vue-dsl-template/src/App.vue\"\n__vue_options__.render = __vue_template__.render\n__vue_options__.staticRenderFns = __vue_template__.staticRenderFns\n__vue_options__._scopeId = \"data-v-7ba5bd90\"\n__vue_options__.style = __vue_options__.style || {}\n__vue_styles__.forEach(function (module) {\n  for (var name in module) {\n    __vue_options__.style[name] = module[name]\n  }\n})\nif (typeof __register_static_styles__ === \"function\") {\n  __register_static_styles__(__vue_options__._scopeId, __vue_styles__)\n}\n\nmodule.exports = __vue_exports__\n\n\n//# sourceURL=webpack:///./src/App.vue?");

/***/ }),

/***/ "./src/main.wx.js":
/*!************************!*\
  !*** ./src/main.wx.js ***!
  \************************/
/*! no exports provided */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _App_vue__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./App.vue */ \"./src/App.vue\");\n/* harmony import */ var _App_vue__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_App_vue__WEBPACK_IMPORTED_MODULE_0__);\n\n_App_vue__WEBPACK_IMPORTED_MODULE_0___default.a.el = \"#app\";\n// eslint-disable-next-line no-undef\nnew Vue(_App_vue__WEBPACK_IMPORTED_MODULE_0___default.a);\n\n\n//# sourceURL=webpack:///./src/main.wx.js?");

/***/ })

/******/ });
