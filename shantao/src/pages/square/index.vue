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
                                <h2>{{item.nickname?item.nickname:item.username}}</h2>
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
                        <div class="tab-item" @click="goview(item,index)">
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
import TabBar from "../../compoment/tebBar.vue"
export default {
    components: {
        TabBar
    },
	data() {
		return {
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
                {
                    user_pic: "http://www.xiastyq.top/cqmp_test/shantaoMusic/avatar/image2.jpg", // 用户头像
                    nickname: "用户1", // 用户昵称
                    username: "12345", // 账号
                    fabulous: 0, // 是否点赞
                    forward: 1, // 是否转发
                    thumbsUp: 1, // 点赞数
                    commentNum: 2, // 回复数
                    forwardNum: 3, // 转发数
                    time: "2024-04-01", // 发布时间
                    content: "哈哈哈哈哈哈哈哈" // 内容
                },
                {
                    user_pic: "http://www.xiastyq.top/cqmp_test/shantaoMusic/avatar/image2.jpg", // 用户头像
                    nickname: "用户1", // 用户昵称
                    username: "12345", // 账号
                    fabulous: 0, // 是否点赞
                    forward: 1, // 是否转发
                    thumbsUp: 1, // 点赞数
                    commentNum: 2, // 回复数
                    forwardNum: 3, // 转发数
                    time: "2024-04-01", // 发布时间
                    content: "哈哈哈哈哈哈哈哈" // 内容
                },
                {
                    user_pic: "http://www.xiastyq.top/cqmp_test/shantaoMusic/avatar/image2.jpg", // 用户头像
                    nickname: "用户1", // 用户昵称
                    username: "12345", // 账号
                    fabulous: 0, // 是否点赞
                    forward: 1, // 是否转发
                    thumbsUp: 1, // 点赞数
                    commentNum: 2, // 回复数
                    forwardNum: 3, // 转发数
                    time: "2024-04-01", // 发布时间
                    content: "哈哈哈哈哈哈哈哈" // 内容
                }
            ],
			title: 'Hello'
		}
	},
	onLoad() {

	},
	methods: {
        // 发起会话
        chagInputPop() {
            this.showInput = !this.showInput;
        },
        // 发布会话
        release() {

        },
        goview() {

        },
        changeData() {

        }
	}
}
</script>
<style lang="less">
@import url("./style/index.less");
</style>