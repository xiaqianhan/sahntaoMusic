// 我的喜欢音乐模块
const express = require('express')
const router = express.Router()

// 导入用户路由处理函数模块
const noticeHandler = require('../router_handler/lovemusic')
// 注：新增音乐类型，type值1为我喜欢的音乐，2为我收藏的音乐。。。。后续可设置多种类型（仅数据量较小的情况下）
// 获取我的音乐列表数据
router.post('/Mylovemusic/get', noticeHandler.getMylovemusic)

// 增加我的音乐列表数据
router.post('/Mylovemusic/add', noticeHandler.addMylovemusic)

// 删除我的音乐列表数据
router.post('/Mylovemusic/delete', noticeHandler.deleteMylovemusic)

module.exports = router