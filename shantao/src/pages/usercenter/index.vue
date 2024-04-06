<template>
    <div class="usercenter">
        <div class="top">
            <div class="icon"><img src="http://www.xiastyq.top/cqmp_test/shantaoMusic/avatar/image1.jpg" alt=""></div>
            <div class="informations" v-if="unsername.length">
                <h3>{{unsername}}</h3>
                <p>山弢映月</p>
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
            unsername: "测试账户",
            moduleList: [{
                itemList: [{
                    type: 1,
                    text: "我的收藏",
                    img: require("../../static/pages/usercenter/collect.png"),
                    url: "/pages/download/index?title=" + encodeURIComponent("我的收藏")
                },{
                    type: 1,
                    text: "我的喜欢",
                    img: require("../../static/pages/usercenter/appraise.png"),
                    url: "/pages/download/index?title=" + encodeURIComponent("我的喜欢")
                },{
                    type: 1,
                    text: "最近播放",
                    img: require("../../static/pages/usercenter/pay.png"),
                    url: "/pages/download/index?title=" + encodeURIComponent("最近播放")
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
                    url: "/pages/download/index?title=" + encodeURIComponent("下载管理")
                },{
                    type: 1,
                    text: "我的歌单",
                    img: require("../../static/pages/usercenter/indent.png"),
                    url: "/pages/download/index?title=" + encodeURIComponent("我的歌单")
                }]
            }],
            mordata: [
                {
                    type: 1,
                    text: "我的消息",
                    img: require("../../static/pages/usercenter/information.png"),
                    url: ""
                },{
                    type: 1,
                    text: "切换账号",
                    img: require("../../static/pages/usercenter/switch.png"),
                    url: ""
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
        this.unsername = wx.getStorageSync("unsername");
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
                this.unsername = "";
                wx.removeStorageSync("unsername");
                return;
            }
            if(!this.unsername && item.type) {
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