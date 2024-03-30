import request from "./request";

export function ceshi() {
    return request.post("/user/findCurrentSerialNum_v1")
}