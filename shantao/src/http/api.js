import request from "./request";
const requesturl = "http://127.0.0.1:3007"


// 注册
export function reguser(username, password) {
    return request.post(requesturl + "/api/reguser", {
        username,
        password
    })
}

// 登录
export function login(username, password) {
    return request.post(requesturl + "/api/login", {
        username,
        password
    })
}

// 修改密码
export function updatepwd(oldPwd, newPwd) {
    return request.post(requesturl + "/my/updatepwd", {
        oldPwd,
        newPwd
    })
}

// 修改用户信息
export function updatepuserinfo(id, nickname, email, user_pic) {
    return request.post(requesturl + "/my/userinfo", {
        id,
        nickname,
        email,
        user_pic
    })
}

// 获取用户信息
export function getuserinfo() {
    return request.get(requesturl + "/my/userinfo")
}

// 获取广场会话列表
export function getMessageList() {
    return request.get(requesturl + "/api/forum")
}

// 广场发起会话及发起评论
export function addMessage(conversation,username,nickname,type,time,content,user_pic) {
    return request.post(requesturl + "/api/forum/add", {
        conversation,username,nickname,type,time,content,user_pic
    })
}

// 获取广场会话列表数据信息
export function forumDetailed(conversation) {
    return request.post(requesturl + "/api/forumDetailed", {
        conversation
    })
}

// 点击回复消息
export function forumDetailedadd(data) {
    return request.post(requesturl + "/api/forumDetailed/add", data)
}

// 获取我的/喜欢 音乐列表数据
export function musicget(username, type) {
    return request.post(requesturl + "/api/Mylovemusic/get", {
        username,
        type
    })
}

// 增加我的/喜欢 音乐列表数据
export function musicadd(username, singer, file_id, url, type, titlename) {
    return request.post(requesturl + "/api/Mylovemusic/add", {
        username,
        singer,
        file_id,
        url,
        type,
        titlename
    })
}

// 删除我的/喜欢 音乐列表数据
export function musicdelete(id, username, type) {
    return request.post(requesturl + "/api/Mylovemusic/delete", {
        id,
        username,
        type
    })
}

// 获取广场会话点赞评论
export function changeData(type, data, conversation) {
    return request.post(requesturl + "/api/forum/update", {
        type,
        data,
        conversation
    })
}

// 获取列表
export function getSongData(text, page, limit) {
    const url = `https://www.kumeiwp.com/index/search/data?page=${page}&limit=${limit}&word=` + encodeURIComponent(text) + "&scope=all"
    return request.post(url)
}

// 获取mp3
export function getactData(fileid) {
    const url = `https://www.kumeiwp.com/file/${fileid}.html`
    return request.get(url)
}