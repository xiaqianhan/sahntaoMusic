export const errorCodeType = function (code) {
    let errMessage = '未知错误'
    switch (code) {
      case 400 || "400":
        errMessage = '请求失败！请您稍后重试'
        break
      case 401 || "401":
        errMessage = '未授权，请重新登录'
        break
      case 403 || "402":
        errMessage = '当前账号无权限访问！'
        break
      case 404 || "404":
        errMessage = '你所访问的资源不存在！'
        break
      case 405 || "405" :
        errMessage = '请求方式错误！请您稍后重试'
        break
      case 408 || "408":
        errMessage = '请求超时！请您稍后重试'
        break
      case 500 || "500":
        errMessage = '服务器端出错'
        break
      case 501 || "501":
        errMessage = '网络未实现'
        break
      case 502 || "502":
        errMessage = '网络错误'
        break
      case 503 || "503":
        errMessage = '服务不可用'
        break
      case 504 || "504":
        errMessage = '网络超时'
        break
      case 505 || "505":
        errMessage = 'http版本不支持该请求'
        break
      default:
        errMessage = `其他连接错误 --${code}`
    }
    return errMessage
  }
  