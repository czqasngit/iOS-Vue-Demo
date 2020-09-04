const path = require("path");
const webpack = require("webpack");
const NativeResourcePlugin = require("./dev/plugins/NativeResourcePlugin");
module.exports = {
  entry: "./src/main.wx.js",
  output: {
    path: path.resolve(__dirname, "dist"),
    filename: "wx.bundle.js",
  },
  mode: "development",
  module: {
    rules: [
      {
        test: /\.(png|jpg|gif)$/,
        use: [
          {
            loader: "file-loader",
            options: {
              name: "[name].[ext]",
              pulbicPath: "./dist/asset/images",
              outputPath: "./asset/images",
            },
          },
        ],
      },
      {
        test: /\.css$/,
        use: ["style-loader", "css-loader"],
      },
      {
        test: /\.vue(\?[^?]+)?$/,
        use: [
          {
            loader: "weex-loader",
          },
        ],
      },
    ],
  },
  plugins: [
    new webpack.BannerPlugin({
      banner: '// { "framework": "Vue"} \n',
      raw: true,
      exclude: "Vue",
    }),
    new NativeResourcePlugin({
      path: "./src/assets",
    }),
  ],
};
