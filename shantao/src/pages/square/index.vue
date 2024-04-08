<template>
    <div class="square">
        <div class="swp">
            <swiper
                indicator-dots="true"
                autoplay="true"
                circular="true"
                indicator-color="#99999950"
                indicator-active-color="#FFFFFF"
                interval="2000"
            >
                <swiper-item v-for="(item, index) in swperdata" :key="index">
                    <div class="itembox">
                        <image :src="item.icon"></image>
                    </div>
                </swiper-item>
            </swiper>
            <div class="title"><p>最热</p></div>
        </div>
        <div class="splitLine"></div>
        <div class="messageBox">
            <div class="addMessages" v-if="MessageList.length" @click="chagInputPop">
                +
            </div>
            <div v-show="MessageList.length" v-for="(item,index) in MessageList" :key="index">
                <div class="conversationList">
                    <div class="conversationInformation">
                        <div class="ico">
                            <image v-if="item.user_pic"  :src="item.user_pic"></image>
                            <image v-else  src="http://www.xiastyq.top/cqmp_test/shantaoMusic/avatar/hedericon.png"></image>
                        </div>
                        <div class="information">
                            <div class="information-top">
                                <h2>{{item.nickname !== "null"?item.nickname:item.username}}</h2>
                                <p>{{item.type}}</p>
                            </div>
                            <div class="information-botton">{{item.time}}</div>
                        </div>
                    </div>
                    <div class="conversationContent" @click="goview(item,index)">
                        <p>{{item.content}}</p>
                    </div>
                    <div class="conversationTab">
                        <div class="tab-item" @click="changeData(1,item,index)">
                            <image v-if="item.fabulous === 1 " src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/fabulous1.png" alt=""></image>
                            <image v-else src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/fabulous2.png" alt=""></image>
                            <p>{{item.thumbsUp}}</p>
                        </div>
                        <div class="tab-item" @click="godetails(item)">
                            <image src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/replyq.png" alt=""></image>
                            <p>{{item.commentNum}}</p>
                        </div>
                        <div class="tab-item" @click="changeData(3,item,index)">
                            <image v-if="item.forward === 1" src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/forward1.png" alt=""></image>
                            <image v-else src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/forward2.png" alt=""></image>
                            <p>{{item.forwardNum}}</p>
                        </div>
                    </div>
                </div>
            </div>
            <div v-if="!MessageList.length" class="conversationNone" @click="chagInputPop">
                <p>暂无会话，点击发起</p>
            </div>
        </div>
        <!-- 添加讯息弹窗 -->
        <div class="inputPop" v-if="showInput">
            <div class="bg" @click="chagInputPop"></div>
            <div class="content-box">
                <div class="title"><h3>添加会话</h3></div>
                <div class="textbox">
                    <h4>内容</h4>
                    <textarea v-model="content" maxlength="-1" placeholder="请输入您想说的话"></textarea>
                    <div class="remaining "><p>{{content.length}}</p></div>
                </div>
                <div class="btnBox">
                    <div class="btn" @click="chagInputPop">取消</div>
                    <div class="btn" @click="release">发布</div>
                </div>
            </div>
        </div>
        <TabBar actIndex="2"></TabBar>
    </div>
</template>
<script>
import * as Api from "../../http/api"
import TabBar from "../../compoment/tebBar.vue"
export default {
    components: {
        TabBar
    },
	data() {
		return {
            userinfo: {},
            showInput: false, // 是否展示输入框
            content: "", // 发布信息内容
            swperdata: [
                {
                    icon: "http://www.xiastyq.top/cqmp_test/shantaoMusic/square/image1.jpg"
                },
                {
                    icon: "http://www.xiastyq.top/cqmp_test/shantaoMusic/square/image2.jpg"
                },
                {
                    icon: "http://www.xiastyq.top/cqmp_test/shantaoMusic/square/image3.jpg"
                },
                {
                    icon: "http://www.xiastyq.top/cqmp_test/shantaoMusic/square/image4.jpg"
                },
                {
                    icon: "http://www.xiastyq.top/cqmp_test/shantaoMusic/square/image5.jpg"
                },
                {
                    icon: "http://www.xiastyq.top/cqmp_test/shantaoMusic/square/image6.jpg"
                }
            ],
            MessageList: [
                // {
                //     user_pic: "http://www.xiastyq.top/cqmp_test/shantaoMusic/avatar/image2.jpg", // 用户头像
                //     nickname: "用户1", // 用户昵称
                //     username: "12345", // 账号
                //     fabulous: 0, // 是否点赞
                //     forward: 1, // 是否转发
                //     thumbsUp: 1, // 点赞数
                //     commentNum: 2, // 回复数
                //     forwardNum: 3, // 转发数
                //     time: "2024-04-01", // 发布时间
                //     content: "哈哈哈哈哈哈哈哈" // 内容
                // },
                // {
                //     user_pic: "http://www.xiastyq.top/cqmp_test/shantaoMusic/avatar/image2.jpg", // 用户头像
                //     nickname: "用户1", // 用户昵称
                //     username: "12345", // 账号
                //     fabulous: 0, // 是否点赞
                //     forward: 1, // 是否转发
                //     thumbsUp: 1, // 点赞数
                //     commentNum: 2, // 回复数
                //     forwardNum: 3, // 转发数
                //     time: "2024-04-01", // 发布时间
                //     content: "哈哈哈哈哈哈哈哈" // 内容
                // },
                // {
                //     user_pic: "http://www.xiastyq.top/cqmp_test/shantaoMusic/avatar/image2.jpg", // 用户头像
                //     nickname: "用户1", // 用户昵称
                //     username: "12345", // 账号
                //     fabulous: 0, // 是否点赞
                //     forward: 1, // 是否转发
                //     thumbsUp: 1, // 点赞数
                //     commentNum: 2, // 回复数
                //     forwardNum: 3, // 转发数
                //     time: "2024-04-01", // 发布时间
                //     content: "哈哈哈哈哈哈哈哈" // 内容
                // }
            ]
		}
	},
    onShow() {
        this.userinfo = wx.getStorageSync("userinfo");
        this.getMessageList();
    },
    // mounted() {
    //     this.userinfo = wx.getStorageSync("userinfo");
    //     this.getMessageList();
    // },
	methods: {
        // 获取会话
        async getMessageList() {
            const res = await Api.getMessageList();
            if(res.status) {
                this.MessageList = res.data.reverse();
                this.isMessageList = true
                this.MessageList.forEach(async (item) => {
                    const requst = await Api.forumDetailed(item.conversation);
                    if(requst.status) {
                        item.commentNum = requst.data.length
                    } else {
                        uni.showToast({
                            icon: "none",
                            title: '会话数据获取失败',
                            duration: 1000
                        });
                    }
                })
            } else {
                uni.showToast({
                    icon: "none",
                    title: '会话数据获取失败',
                    duration: 1000
                });
            }
        },
        // 发起会话
        chagInputPop() {
            this.showInput = !this.showInput;
        },
        // 发布会话
        async release() {
            console.log(this.content.length);
            if(this.content.length>0){
                const res = await Api.addMessage(
                    this.random(), // 会话编号
                    this.userinfo.username, // 发布人账户
                    this.userinfo.nickname, // 发布人昵称
                    "", // 发布对应音乐
                    this.getNowDate(), // 发布时间
                    this.content, // 发布内容
                    this.userinfo.user_pic
                )
                if (res.status) {
                    this.content = ""
                    this.showInput = false;
                    this.getMessageList();
                    uni.showToast({
                        title: '信息发布成功',
                        duration: 1000
                    });
                } else {
                     uni.showToast({
                        icon: "none",
                        title: '信息发布失败',
                        duration: 1000
                    });
                }
            } else {
                uni.showToast({
                    icon: "none",
                    title: '请填写发布内容',
                    duration: 1000
                });
            }
        },
        // 生成随机数
        random() {
            var Num="";
            for(var i=0;i<8;i++)
            {
                Num+=Math.floor(Math.random()*10);
            }
            return Num
        },
        // 查询当天日期
        getNowDate() {
            const date = new Date();
            const sign2 = ":";
            let year = date.getFullYear() // 年
            let month = date.getMonth() + 1; // 月
            let day = date.getDate(); // 日
            let hour = date.getHours(); // 时
            let minutes = date.getMinutes(); // 分
            let seconds = date.getSeconds() //秒
            // 给一位数的数据前面加 “0”
            if (month >= 1 && month <= 9) {
                month = "0" + month;
            }
            if (day >= 0 && day <= 9) {
                day = "0" + day;
            }
            if (hour >= 0 && hour <= 9) {
                hour = "0" + hour;
            }
            if (minutes >= 0 && minutes <= 9) {
                minutes = "0" + minutes;
            }
            if (seconds >= 0 && seconds <= 9) {
                seconds = "0" + seconds;
            }
            return year + "-" + month + "-" + day + " " + hour + sign2 + minutes + sign2 + seconds;
        },
        // 前往详情
        godetails(item) {
            if (this.userinfo){
                // uni.setStorageSync('message_details', JSON.stringify(item));
                uni.setStorage({
                    key: 'message_details',
                    data: item,
                    success() {
                        console.log("通知信息存储完成");
                        // 跳转到详情页面
                        uni.navigateTo({
                            url: '/pages/square/details?type=1'
                        })
                    }
                })
            }else{
                wx.showToast({
                    title: "请登录账号",
                    icon: "none",
                    duratioon: 1000
                })
            }
        },
        // 点赞评论转发，1为点赞，2为评论，3为转发
        async changeData(type,item,index) {
            if (!item.fabulous) {
                return;
            }
            if (this.userinfo){
                if(item.fabulous || item.forward) {
                    if (type == 1 && item.fabulous === 1) {
                        this.MessageList[index].fabulous = 0
                        this.conversationData = item.thumbsUp + 1
                    } else if (type == 2){
                        // this.tabShow.reply = false
                        this.conversationData = item.commentNum + 1
                    } else if (type == 3 && item.forward == 1){
                        this.MessageList[index].forward = 0
                        this.conversationData = item.forwardNum + 1
                    }
                    const res = await Api.changeData(type, this.conversationData, item.conversation);
                    if (res) {
                        if (type == 1) {
                            this.MessageList[index].thumbsUp = item.thumbsUp + 1;
                        } else if (type == 3){
                            this.MessageList[index].forwardNum = item.forwardNum + 1;
                        }
                    }
                }
            }
        }
	},
    // 下拉刷新
    onPullDownRefresh() {
        console.log('refresh');
        this.getMessageList()
        setTimeout(function () {
            uni.stopPullDownRefresh();
        }, 1000);
    }
}
</script>
<style lang="less">
@import url("./style/index.less");
</style>