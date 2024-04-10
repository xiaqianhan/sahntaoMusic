/**
 * 我的喜欢音乐处理模块
 */
// 导入数据库操作模块
const db = require('../db/index')

// 获取我的音乐列表数据的处理函数
exports.getMylovemusic = (req, res) => {
    console.log(req.body);
    const sql = 'select * from ev_lovemusic where username=? and type=?'

    db.query(sql, [req.body.username, req.body.type], (err, results) => {
        // 1. 执行 SQL 语句失败
        if (err) return res.cc(err)
        
        // 2. 执行 SQL 语句成功
        res.send({
            status: 1,
            message: '获取音乐列表数据成功！',
            data: results,
        })
    })
}

// 删除我的音乐列表数据的处理函数
exports.deleteMylovemusic = (req, res) => {
    const sql = 'delete from ev_lovemusic  where id=? and username=? and type=?'

    db.query(sql, [req.body.id, req.body.username, req.body.type], (err, results) => {
        // 1. 执行 SQL 语句失败
        if (err) return res.cc(err)
        
        // 2. 执行 SQL 语句成功
        res.send({
            status: 1,
            message: '删除音乐数据成功',
            data: results,
        })
    })
}

// 增加我的音乐列表数据的处理函数
exports.addMylovemusic = (req, res) => {
    console.log(req.body);
    // 定义查询话题编号是否被占用的 SQL 语句
    const sql = `select * from ev_lovemusic where file_id=? and type=?`

    db.query(sql, [req.body.file_id, req.body.type], (err, results) => {
        // 1. 执行 SQL 语句失败
        if (err) return res.cc(err)
        
        // 2. 执行 SQL 语句成功
        // 商品编号被占用
        if (results.length >= 1) return res.cc('该音乐已添加至列表，请直接进行数据操作！')

        // 新增论坛列表数据
        const sqls = `insert into ev_lovemusic set ?`

        db.query(sqls, req.body, (err, results) => {
            // 1. 执行 SQL 语句失败
            if (err) return res.cc(err)
        
            // 2. 执行 SQL 语句成功
            res.send({
                status: 1,
                message: '新增音乐信息成功！',
                data: results,
            })
        })
    })
}