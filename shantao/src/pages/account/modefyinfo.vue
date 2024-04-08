<template>
    <div class="login">
        <div class="logo">
            <div class="icon"><img src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/tb31.png" alt=""></div>
            <h3>山弢映月</h3>
        </div>
        <div class="entrybox">
            <div class="entrycont">
                <p>用户账号：</p>
                <p class="showtext">{{usinfo.username}}</p>
            </div>
            <div class="entrycont">
                <p>用户昵称：</p>
                <input v-model="userdata.nickname" type="text" placeholder="请输入用户昵称" />
            </div>
            <div class="entrycont">
                <p>用户邮箱:</p>
                <input v-model="userdata.email" type="text" placeholder="请输入邮箱">
            </div>
            <div class="entrycont">
                <p>用户头像:</p>
                <div class="seletbox">
                    <div class="avatarbox">
                        <div class="selectave" :class="selecindex==index?'selectact':''" @click="selctavatar(index)" v-for="(item,index) in 6" :key="index">
                            {{index + 1}}
                        </div>
                    </div>
                    <div class="icon">
                        <img :src="iconsrc" alt="" />
                    </div>
                </div>
                
                
            </div>
        </div>
        <div class="loginbtn" @click="login">修改</div>
    </div>
</template>
<script>
import * as Api from "../../http/api";
export default {
    data () {
        return {
            selecindex: 0,
            iconsrc: "http://www.xiastyq.top/cqmp_test/shantaoMusic/avatar/image1.jpg",
            usinfo: {},
            userdata: {
                username: "",
                email:""
            }
        }
    },
    mounted() {
        this.usinfo = wx.getStorageSync("userinfo");
    },
    methods: {
        selctavatar(index) {
            this.selecindex = index;
            this.iconsrc = `http://www.xiastyq.top/cqmp_test/shantaoMusic/avatar/image${index + 1}.jpg`
        },
        gologin() {
            wx.navigateTo({
                url: "/pages/account/login"
            })
        },
        async login() {
            const { nickname, email } = this.userdata;
            if (!nickname) {
                return wx.showToast({
                    title: "用户昵称不能为空",
                    icon: "none",
                    duratioon: 1000
                })
            }
            if (!email) {
                return wx.showToast({
                    title: "邮箱不能为空",
                    icon: "none",
                    duratioon: 1000
                })
            }
            const res = await Api.updatepuserinfo(this.usinfo.id, nickname, email, this.iconsrc);
            if (res.status) {
                wx.showToast({
                    title: "信息修改成功",
                    icon: "none",
                    duratioon: 1000
                })
                const userinfo = await Api.getuserinfo();
                if(userinfo.status) {
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
                if (res.data.message === '"email" must be a valid email'){
                    wx.showToast({
                        title: "邮箱格式有误！",
                        icon: "none",
                        duratioon: 1000
                    })
                } else {
                    wx.showToast({
                        title: res.message,
                        icon: "none",
                        duratioon: 1000
                    })
                }
            }
        }
    }
}
</script>
<style lang="less">
@import url("./style/index.less");
</style>