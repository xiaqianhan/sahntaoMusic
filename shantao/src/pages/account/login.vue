<template>
    <div class="login">
        <div class="logo">
            <div class="icon"><img src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/tb31.png" alt=""></div>
            <h3>山弢映月</h3>
        </div>
        <div class="entrybox">
            <div class="entrycont">
                <p>用户名：</p>
                <input v-model="userdata.username" type="text" placeholder="请输入用户名" />
            </div>
            <div class="entrycont">
                <p>密码：</p>
                <input v-model="userdata.password" type="password" placeholder="请输入密码">
            </div>
        </div>
        <div class="loginbtn" @click="login">登录</div>
        <p class="logtos">没有账号，点击<span @click="goregister">注册</span></p>
    </div>
</template>
<script>
import * as Api from "../../http/api";
export default {
    data () {
        return {
            userdata: {
                username: "",
                password: ""
            }
        }
    },
    mounted() {
    },
    methods: {
        goregister() {
            wx.navigateTo({
                url: "/pages/account/register"
            })
        },
         async login() {
            const { username, password} = this.userdata;
            if (!username) {
                return wx.showToast({
                    title: "请输入用户名称",
                    icon: "none",
                    duratioon: 1000
                })
            }
            if (!password) {
                return wx.showToast({
                    title: "请输入密码",
                    icon: "none",
                    duratioon: 1000
                })
            }
            const res = await Api.login(username, password)
            // console.log(res);
            if(res.status) {
                wx.setStorageSync("token", res.token);
                const userinfo = await Api.getuserinfo();
                if(userinfo.status) {
                    wx.showToast({
                        title: "登录成功",
                        icon: "none",
                        duratioon: 1000
                    })
                    wx.setStorageSync("userinfo", userinfo.data);
                    wx.reLaunch({
                        url: "/pages/usercenter/index"
                    })
                } else {
                    wx.showToast({
                        title: "获取用户信息失败，请稍后重试",
                        icon: "none",
                        duratioon: 1000
                    })
                }
            } else {
                wx.showToast({
                    title: "请输入正确的账号密码",
                    icon: "none",
                    duratioon: 1000
                })
            }
        }
    }
}
</script>
<style lang="less">
@import url("./style/index.less");
</style>