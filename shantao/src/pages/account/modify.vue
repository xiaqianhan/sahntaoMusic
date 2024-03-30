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
                <p>旧密码：</p>
                <input v-model="userdata.password" type="password" placeholder="请输入密码">
            </div>
            <div class="entrycont">
                <p>新密码：</p>
                <input v-model="userdata.password" type="password" placeholder="请输入密码">
            </div>
        </div>
        <div class="loginbtn" @click="login">修改</div>
        <p class="logtos">放弃修改，点击<span @click="gologin">登录</span></p>
    </div>
</template>
<script>
export default {
    data () {
        return {
            userdata: {
                username: "",
                oldpassword: "",
                newpassword:""
            }
        }
    },
    mounted() {
    },
    methods: {
        gologin() {
            wx.navigateTo({
                url: "/pages/account/login"
            })
        },
        login() {
            const { username, oldpassword, newpassword } = this.userdata;
            if (!username) {
                return wx.showToast({
                    title: "用户名称不能为空",
                    icon: "none",
                    duratioon: 1000
                })
            }
            if (!oldpassword) {
                return wx.showToast({
                    title: "旧密码不能为空",
                    icon: "none",
                    duratioon: 1000
                })
            }
            if (!oldpassword) {
                return wx.showToast({
                    title: "新密码不能为空",
                    icon: "none",
                    duratioon: 1000
                })
            }
            wx.reLaunch({
                url: "/pages/account/login"
            })
        }
    }
}
</script>
<style lang="less">
@import url("./style/index.less");
</style>