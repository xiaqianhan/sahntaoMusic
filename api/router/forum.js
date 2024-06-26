// 广场列表模块
const express = require('express')
const router = express.Router()

// 导入用户路由处理函数模块
const noticeHandler = require('../router_handler/forum')

// 获取广场首页列表数据
router.get('/forum', noticeHandler.getforum)

// 新增广场首页列表数据
router.post('/forum/add', noticeHandler.addforum)

// 修改广场首页列表数据(点赞)
router.post('/forum/update', noticeHandler.updateData)

// 修改广场首页列表数据(点赞)
router.post('/forum/delectcontent', noticeHandler.delectcontent)

// 新增暂存广场信息列表
router.post('/zhancun/staging', noticeHandler.staging)

// 获取暂存广场的信息列表
router.post('/zhancun/getStaging', noticeHandler.getStaging)

module.exports = router
