var webpack = require('webpack')
module.exports = {
  lintOnSave: true,
  configureWebpack: {
    plugins: [
      new webpack.DefinePlugin({
        'process': {},
      })
    ]
  }
}
