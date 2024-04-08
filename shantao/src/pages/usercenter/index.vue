<template>
    <div class="usercenter">
        <div class="top">
            <div class="icon">
                <img v-if="usinfo.user_pic" :src="usinfo.user_pic" alt="">
                <img v-else src="http://www.xiastyq.top/cqmp_test/shantaoMusic/avatar/hedericon.png" alt="">
            </div>
            <div class="informations" v-if="islogin">
                <h3>{{usinfo.nickname?usinfo.nickname:usinfo.username}}</h3>
                <p>{{usinfo.nickname?usinfo.username:"山弢映月"}}</p>
            </div>
            <div class="informations" @click="gologin" v-else>
                <h3>点击注册/登录</h3>
                <p>快人一步</p>
            </div>
        </div>
        <div class="content">
            <div class="box">
                <div class="banner boxs">
                    <div class="option" @click="recommendation">
                        <div class="icon"><img src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/dynamic.png" alt=""></div>
                        <h3>推荐</h3>
                    </div>
                    <div class="cutApart"></div>
                    <div class="option" @click="dynamic">
                        <div class="icon"><img src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/recommendation.png" alt=""></div>
                        <h3>动态</h3>
                    </div>
                </div>
                <div class="announcement boxs">
                    <div class="title">用户须知</div>
                    <p>本小程序仅用于个人</p>
                </div>
                <div class="myIndent boxs">
                    <div class="title">
                        <h3>我的模块</h3>
                    </div>
                    <div class="contex" v-for="(item,index) in moduleList" :key="index">
                        <template>
                            <div class="itembox" v-for="(items,indexs) in item.itemList" :key="indexs">
                                <div class="itemcont" @click="goview(items)">
                                    <div class="icon"><img :src="items.img" alt=""></div>
                                    <p>{{items.text}}</p>
                                </div>
                                <!-- <span v-if="items.num>0">{{items.num}}</span> -->
                            </div>
                        </template>
                    </div>
                </div>
                <div class="myIndent boxs">
                    <div class="title">
                        <h3>其他</h3>
                    </div>
                    <div class="contex">
                        <div class="itembox" v-for="(item, index) in mordata" :key="index">
                            <div class="itemcont" @click="goview(item)">
                                <div class="icon"><img :src="item.img" alt=""></div>
                                <p>{{item.text}}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <TabBar actIndex="3"></TabBar>
    </div>
</template>
<script>
import TabBar from "../../compoment/tebBar.vue"
export default {
    components: {
        TabBar
    },
    data () {
        return {
            islogin: false,
            usinfo: {}, // 用户信息
            moduleList: [{
                itemList: [{
                    type: 1,
                    text: "我的收藏",
                    img: require("../../static/pages/usercenter/collect.png"),
                    url: "/pages/download/index?title=" + encodeURIComponent("我的收藏") + "&type=1"
                },{
                    type: 1,
                    text: "我的喜欢",
                    img: require("../../static/pages/usercenter/appraise.png"),
                    url: "/pages/download/index?title=" + encodeURIComponent("我的喜欢") + "&type=2"
                },{
                    type: 1,
                    text: "最近播放",
                    img: require("../../static/pages/usercenter/pay.png"),
                    url: "/pages/download/index?title=" + encodeURIComponent("最近播放") + "&type=3"
                }]
            },{
                itemList: [{
                    type: 0,
                    text: "音乐广场",
                    img: require("../../static/compoment/tabBar/square.png"),
                    url: "/pages/square/index"
                },{
                    type: 0,
                    text: "下载管理",
                    img: require("../../static/pages/usercenter/drawback.png"),
                    url: "/pages/download/index?title=" + encodeURIComponent("下载管理") + "&type=4"
                },{
                    type: 1,
                    text: "我的歌单",
                    img: require("../../static/pages/usercenter/indent.png"),
                    url: "/pages/download/index?title=" + encodeURIComponent("我的歌单") + "&type=5"
                }]
            }],
            mordata: [
                {
                    type: 1,
                    text: "修改信息",
                    img: require("../../static/pages/usercenter/modify.png"),
                    url: ""
                },{
                    type: 1,
                    text: "修改密码",
                    img: require("../../static/pages/usercenter/chaepassword.png"),
                    url: "/pages/account/modify"
                },{
                    type: 1,
                    text: "切换账号",
                    img: require("../../static/pages/usercenter/switch.png"),
                    url: "/pages/account/login"
                },{
                    type: 0,
                    text: "退出登录",
                    img: require("../../static/pages/usercenter/quit.png"),
                    url: ""
                }
            ]
        }
    },
    mounted() {
        this.usinfo = wx.getStorageSync("userinfo");
        if (!!this.usinfo.username) {
            this.islogin = true;
        }
        // this.unsername = wx.getStorageSync("unsername");
    },
    methods: {
        recommendation() {
            wx.navigateTo({
                url: "/pages/songsheet/index?title=" + encodeURIComponent("推荐")
            })
        },
        dynamic() {
            wx.navigateTo({
                url: "/pages/active/index"
            })
        },
        gologin() {
            wx.navigateTo({
                url: "/pages/account/login"
            })
        },
        goview(item){
            if(item.text === "退出登录") {
                this.islogin = false;
                this.usinfo = {};
                wx.removeStorageSync("token");
                wx.removeStorageSync("userinfo");
                wx.showModal({
                    title: '提示',
                    content: '退出成功',
                })
                return;
            }
            if(!this.islogin && item.type) {
                wx.showModal({
                    title: '提示',
                    content: '请登录后使用',
                    success (res) {
                        if (res.confirm) {
                            console.log('用户点击确定')
                        } else if (res.cancel) {
                            console.log('用户点击取消')
                        }
                    }
                })
                return;
            }
            wx.navigateTo({
                url: item.url
            })
        }
    }
}
</script>
<style lang="less">
@import url("./style/index.less");
</style>