import request from "./request";

export function ceshi() {
    return request.post("/user/findCurrentSerialNum_v1")
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