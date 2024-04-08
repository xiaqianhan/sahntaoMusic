<template>
    <div class="login">
        <div class="logo">
            <div class="icon"><img src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/tb31.png" alt=""></div>
            <h3>山弢映月</h3>
        </div>
        <div class="entrybox">
            <!-- <div class="entrycont">
                <p>用户名：</p>
                <input v-model="userdata.username" type="text" placeholder="请输入用户名" />
            </div> -->
            <div class="entrycont">
                <p>旧密码：</p>
                <input v-model="userdata.oldpassword" type="password" placeholder="请输入密码">
            </div>
            <div class="entrycont">
                <p>新密码：</p>
                <input v-model="userdata.newpassword" type="password" placeholder="请输入密码">
            </div>
            <div class="entrycont">
                <p>二次密码：</p>
                <input v-model="userdata.newspassword" type="password" placeholder="请输入密码">
            </div>
            <div class="yanzheng">
                <input type="text" v-model="mes" placeholder="请输入验证码">
                <div class="getmes" :class="isgry?'getmesgry':'getmesact'" @click="getmes">{{mesbtntext}}</div>
            </div>
        </div>
        <p class="mestext">获取的验证码：{{mestext}}</p>
        <div class="loginbtn" @click="login">修改</div>
        <p class="logtos">放弃修改，点击<span @click="gologin">登录</span></p>
    </div>
</template>
<script>
import * as Api from "../../http/api";
export default {
    data () {
        return {
            mestext: "",
            isgettime: false,
            time: 60,
            timer: null,
            isgry: false,
            mesbtntext: "获取验证码",
            mes: "",
            userdata: {
                username: "",
                oldpassword: "",
                newpassword:"",
                newspassword: ""
            }
        }
    },
    mounted() {
    },
    methods: {
        getmes() {
            if (this.isgettime) {
                return;
            }
            this.isgettime = true;
            this.mestext = this.random();
            this.timer = setInterval(() => {
                this.time -= 1;
                this.mesbtntext = this.time + "s"
                this.isgry = true;
                if(this.time === 0) {
                    this.isgettime = false;
                    this.time = 60;
                    this.isgry = false;
                    clearInterval(this.timer);
                    this.mesbtntext = "重新获取"
                }
            }, 1000)
        },
        gologin() {
            wx.navigateTo({
                url: "/pages/account/login"
            })
        },
        random() {
            var Num="";
            for(var i=0;i<6;i++)
            {
                Num+=Math.floor(Math.random()*10);
            }
            return Num
        },
        async login() {
            const { oldpassword, newpassword, newspassword } = this.userdata;
            // if (!username) {
            //     return wx.showToast({
            //         title: "用户名称不能为空",
            //         icon: "none",
            //         duratioon: 1000
            //     })
            // }
            if (!oldpassword) {
                return wx.showToast({
                    title: "旧密码不能为空",
                    icon: "none",
                    duratioon: 1000
                })
            }
            if (!newpassword || !newspassword) {
                return wx.showToast({
                    title: "新密码不能为空",
                    icon: "none",
                    duratioon: 1000
                })
            }
            if (!this.mes) {
                return wx.showToast({
                    title: "验证码不能为空",
                    icon: "none",
                    duratioon: 1000
                })
            }
            if (newpassword.length < 6) {
                return wx.showToast({
                    title: "密码至少为6位数",
                    icon: "none",
                    duratioon: 1000
                })
            }
            if (newpassword !== newspassword) {
                return wx.showToast({
                    title: "两次密码输入不一致",
                    icon: "none",
                    duratioon: 1000
                })
            }
            if (this.mes !== this.mestext) {
                return wx.showToast({
                    title: "验证码输入错误",
                    icon: "none",
                    duratioon: 1000
                })
            }
            const res = await Api.updatepwd(oldpassword, newpassword);
            if(res.status) {
                wx.showToast({
                    title: "修改密码成功，请重新登录",
                    icon: "none",
                    duratioon: 1000
                })
                const time = setTimeout(() => {
                    wx.removeStorageSync("userinfo");
                    wx.removeStorageSync("token");
                    clearTimeout(time);
                    wx.reLaunch({
                        url: "/pages/account/login"
                    })
                }, 1000)
            } else {
                // 身份认证失败即登录过期
                wx.showToast({
                    title: res.message,
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