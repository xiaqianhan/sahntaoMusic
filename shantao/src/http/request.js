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