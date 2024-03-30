const path = require('path')
const resolve = dir => path.join(__dirname, dir)
const { defineConfig } = require("@vue/cli-service");
module.exports = defineConfig({
    chainWebpack: (config) => {
        // config.module
        // .rule("mjs$")
        // .test(/.mjs$/)
        // .include.add(/node_modules/)
        // .end()
        // .type("javascript/auto");
        // config.resolve.alias.set("@", resolve("src"))
        // 忽略后缀名的配置选项, 添加 .vue 选项时要记得原本默认忽略的选项也要手动写入
        // config.resolve.extensions: ['.mjs', '.js', '.ts', '.jsx', '.tsx', '.json', '.vue'],
    },
});