export default {
    get(url, params, Objec) {
        return this.request(url, params, 'GET');
    },
    post(url, params, Objec) {
        return this.request(url, params, 'POST');
    },
    request(url, params, method) {
        return new Promise((resolve, reject) => {
            uni.request({
                url: url,
                data: params,
                header: {
                    'content-type': 'application/x-www-form-urlencoded', //自定义请求头信息
                    'Authorization': wx.getStorageSync("token")
                },
                method: method,
                success: (res) => {
                    resolve(res.data);
                },
                fail: (err) => {
                    reject(err);
                }
            });
        });
    }
}