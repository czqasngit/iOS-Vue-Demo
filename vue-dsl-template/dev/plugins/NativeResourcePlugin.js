/* eslint-disable no-unused-vars */
const fs = require("fs");
const path = require("path");

/// 复制处理成android需要的图片资源
function _copyAndroidResources(list, dist, src) {}
/// 复制处理成iOS需要的图片资源
function _copyIOSResrouces(list, dist, src) {
  const bundle_path = path.resolve(dist, "assets.bundle");
  if (!fs.existsSync(bundle_path)) fs.mkdirSync(bundle_path);
  list.forEach((name) => {
    const img_path = path.resolve(bundle_path, name);
    const src_img_path = path.resolve(src, name);
    fs.copyFileSync(src_img_path, img_path);
  });
}
/// 复制图片到指定的目录
function _copyResources(list, dist, src) {
  _copyIOSResrouces(list, dist, src);
  _copyIOSResrouces(list, dist, src);
}

function NativeResourcePlugin(options) {
  /// 资源文件相对位置
  const resources_path = options.path ?? "./src/assets";
  /// 目标目录
  const dist_path = options.dist ?? "./dist";
  const stat = fs.statSync(resources_path);
  if (!stat.isDirectory) throw new Error(`${resources_path} 不是一个有效的目录`);
  /// 读取图片列表
  const list = fs.readdirSync(resources_path);
  /// 如果目录目录不存在,则创建
  if (!fs.existsSync(dist_path)) fs.mkdirSync(dist_path);
  const dist_assets_path = path.resolve(dist_path, "assets");
  if (!fs.existsSync(dist_assets_path)) fs.mkdirSync(dist_assets_path);
  _copyResources(list, dist_assets_path, resources_path);
}
//插件函数的 prototype 上定义一个 apply 方法
NativeResourcePlugin.prototype.apply = (compiler) => {
  //hooks
  compiler.hooks.done.tap("NativeResourcePlugin", (status) => {
    console.log("编译完成");
  });
  console.log("optimize");
};

module.exports = NativeResourcePlugin;
