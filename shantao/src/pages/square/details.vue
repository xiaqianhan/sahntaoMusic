<template>
    <div class="content">
        <!-- 讯息消息 -->
        <div class="message">
            <div class="details">
                <div class="ico"><image :src="sponsor.user_pic?sponsor.user_pic:'http://www.xiastyq.top/cqmp_test/shantaoMusic/avatar/hedericon.png'" alt=""></image></div>
                <div class="users">
                    <div class="usertop">
                        <h2>{{sponsor.nickname !== "null" ?sponsor.nickname:sponsor.username}}</h2>
                        <p>{{sponsor.type?sponsor.type:""}}</p>
                    </div>
                    <p>{{sponsor.time}}</p>
                </div>
            </div>
            <div class="contents">{{sponsor.content}}</div>
            <div class="group">
                <div class="icon">
                    <image v-if="tabShow.fabulous" src="http://pic.yupoo.com/1950343156/e2657db8/46c63afd.png" alt=""></image>
                    <image v-if="!tabShow.fabulous" src="http://pic.yupoo.com/1950343156/61dfaa62/9d843db2.png" alt=""></image>
                </div>
                <div class="icon"><image src="http://pic.yupoo.com/1950343156/0926d046/5ab4ce00.png" alt=""></image></div>
                <div class="icon">
                    <image v-if="tabShow.forward" src="http://pic.yupoo.com/1950343156/81695fae/efcb4a85.png" alt=""></image>
                    <image v-if="!tabShow.forward" src="http://pic.yupoo.com/1950343156/a4a8c60b/0eb10b7c.png" alt=""></image>
                </div>
            </div>
        </div>
        <!-- 分割线 -->
        <div class="division"></div>
        <!-- 回复消息 --> 
        <div class="replyBOx" v-show="replyList.length > 0">
            <div class="reply" v-for="(item,index) in replyList" :key="index">
                <div class="details">
                    <div class="ico"><image :src="item.user_pic?item.user_pic:'http://www.xiastyq.top/cqmp_test/shantaoMusic/avatar/hedericon.png'" alt=""></image></div>
                    <div class="users">
                        <div class="usertop">
                            <h2>{{item.nickname !== "null" ?item.nickname:item.username}}</h2>
                            <p>{{item.type?item.type:""}}</p>
                            <!-- <h2>{{item.nickname}}</h2>
                            <p>{{item.type}}</p> -->
                        </div>
                        <p>{{item.time}}</p>
                    </div>
                </div>
                <div class="contents">{{item.content}}</div>
            </div>
        </div>
        <div class="replyBOx" v-show="replyList.length == 0">
            <div class="noreply">
                <image src="http://pic.yupoo.com/1950343156/faf319bb/7be4bda2.png" alt=""></image>
                <p>暂无回复，点击回复</p>
            </div>
        </div>
        <div class="bottonDetails">
            <input type="text" v-model="replyText">
            <div class="ico" @click="sendOuTreply()"><image src="http://pic.yupoo.com/1950343156/3e5f62bb/73861f10.png" alt=""></image></div>
        </div>
    </div>
</template>
<script>
import * as Api from "../../http/api"
export default {
    data() {
        return {
            qw: "hahahahh",
            userinfo: {},
            sessionid: "",
            tabShow: {
                    fabulous: true, // 点赞
                    reply: true, // 回复
                    forward: true, // 转发
            },
            sponsor: {}, // 会话发起着信息
            replyList: [], // 回复列表消息
            replyText: "", // 回复消息内容
            id: "" // id编号
        }
    },
    mounted() {
        // this.id = this.$root.$mp.query.id;
        this.userinfo = wx.getStorageSync('userinfo');
        this.sponsor = wx.getStorageSync('message_details');
        this.sessionid = this.sponsor.conversation;
        this.getSponsorList();
        this.getMessageList();
    },
    methods: {
        // 获取发起人信息
        async getSponsorList() {
            const res = await Api.getMessageList();
            if (res.status) {
                this.sponsor = res.data[this.id];
                this.getMessageList();
            } else {
                uni.showToast({
                    icon: "none",
                    title: '会话数据获取失败',
                    duration: 1000
                });
            }
        },
        // 获取消息回复列表
        async getMessageList() {
            const res = await Api.forumDetailed(this.sessionid);
            if (res.status) {
                this.replyList = res.data;
            } else {
                uni.showToast({
                    icon: "none",
                    title: '会话数据获取失败',
                    duration: 1000
                });
            }
        },
        // 点击回复消息
        async sendOuTreply() {
            if(this.replyText.length > 0){
                const res = await Api.forumDetailedadd({
                        conversation: this.sessionid, // 会话编号
                        username: this.userinfo.username, // 用户账户
                        nickname: this.userinfo.nickname, // 用户昵称
                        type: "", // 音乐名称
                        time: this.getNowDate(), // 回复时间
                        content: this.replyText// 回复内容
                    })
                if (res.status) {
                    this.replyText = ""
                    this.getMessageList();
                    uni.showToast({
                        title: '信息发送成功',
                        duration: 1000
                    });
                } else {
                    uni.showToast({
                        icon: "none",
                        title: '信息发送失败',
                        duration: 1000
                    });
                }
            } else {
                uni.showToast({
                    icon: "none",
                    title: '信息内容不能为空',
                    duration: 1000
                });
            }
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
        }
    }
}
</script>
<style scoped>
.content{
    width: 100vw;
    margin-bottom: 15px;
}
/* 发布者信息 */
.message{
    width: 100%;
    padding: 17px;
    box-sizing: border-box;
}
.details{
    display: flex;
    align-items: center;
}
.details .ico{
    width: 40px;
    height: 40px;
    margin-right: 10px;
    /* background-color: aqua; */
    border-radius: 50%;
}
.details .ico image{
    width: 100%;
    height: 100%;
}
.details .users{
    display: flex;
    flex-direction: column;
}
.details .users p{
    font-size: 14px;
    color: #9A9A9A9A;
}
.details .users .usertop{
    display: flex;
    align-items: flex-end;
}
.details .users .usertop h2{
    font-weight: 500;
    font-size: 17px;
    margin-right: 10px;
}
.details .users .usertop p{
    font-size: 14px;
}
.contents{
    padding: 5px 15px;
    box-sizing: border-box;
    margin-bottom: 20px;
    margin-top: 10px;
    font-size: 17px;
}
.group{
    display: flex;
    float: right;
    margin-right: 20px;
}
.group .icon{
    width: 25px;
    height: 25px;
    margin-left: 10px;
}
.group .icon image{
    width: 100%;
    height: 100%;
}
/* 分割线 */
.division{
    width: 100%;
    height: 0.3px;
    background-color: #BBBBBB;
    box-shadow: 0px 2px 3px 0px #000000;
    margin-top: 30px;
}
.replyBOx{
    margin-top: 36px;
}
.reply{
    width: 100%;
    padding: 0 27px;
    box-sizing: border-box;
    margin-top: 20px;
}
.noreply{
    margin-top: 110px;
    width: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    color: #BBBBBB;
}
.noreply image{
    width: 120px;
    height: 120px;
    margin-bottom: 10px;
}
.bottonDetails{
    position: fixed;
    width: 100%;
    height: 69px;
    border: 1px solid #BBBBBB;
    bottom: 0;
    left: 0;
    box-shadow: 0px -3px 2px 0px #9A9A9A9A;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 10px 20px;
    box-sizing: border-box;
}
.bottonDetails input{
    border: 1px solid #BBBBBB;
    width: 87%;
    height: 35px;
    padding: 0 10px;
    box-sizing: border-box;
}
.bottonDetails .ico{
    width: 35px;
    height: 35px;
}
.bottonDetails .ico image{
    width: 100%;
    height: 100%;
}
</style>