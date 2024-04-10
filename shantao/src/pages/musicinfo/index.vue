<template>
    <div class="musicinfo">
        <div class="musiceicon_box">
            <div class="outer_layer" :class="isAutoPlay?'rotateimg':''">
                <div class="disk"></div>
            </div>
            <div class="pointer" :class="pointerStyle">
                <img src="https://p5.music.126.net/obj/wonDlsKUwrLClGjCm8Kx/28513977227/139b/06a3/e1e3/929b3b4b49bf5c6ef05c795e9e1f2516.png" alt="">
            </div>
        </div>
        <div class="lyric_box">
            <p>暂无歌词</p>
        </div>
        <div class="musicline">
            <div class="nowtime" :style="{ width: (timeinfo.nowTime / timeinfo.totalTime) * 100 + '%' }"></div>
        </div>
        <div class="timebox">
            <p>{{timeinfo.showtnowTime}}</p>
            <p>{{timeinfo.showtotalTime}}</p>
        </div>
        <div class="broadcast">
            <div class="musicinfo_cats">
                <div class="info_lef">
                    <h3>{{musicinfo.titlename}}</h3>
                    <p>{{musicinfo.singer}}</p>
                </div>
                <div class="info_rig">
                    <div class="icon" @click="changelove">
                        <img v-if="!islove" src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/love.png" alt="" />
                        <img v-else src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/loves.png" alt="" />
                    </div>
                    <div class="icon" @click="changdiscuss"><img src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/tb9.png" alt="" /></div>
                </div>
            </div>
            <div class="control">
                <div class="suitable icoon1" @click="chngepaytype">
                    <img v-if="playtype" src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/repeat2.png" alt="">
                    <img v-else src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/repeatOnce2.png" alt="">
                </div>
                <div class="previous_song icoon1" @click="previous"><img src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/previous.png" alt=""></div>
                <div class="playbtn" @click="playmusic">
                    <img v-if="!isAutoPlay" src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/playopen.png" alt="">
                    <img v-else src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/playstop.png" alt="">
                </div>
                <div class="next_song icoon1" @click="next"><img src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/next.png" alt=""></div>
                <div class="musiclist icoon1" @click="changelist"><img src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/musiclist.png" alt=""></div>
            </div>
            <div class="labbox">
                <div class="item" @click="collection(2)">
                    <div class="icon"><img src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/tb12.png" alt="" /></div>
                    <p>收藏</p>
                </div>
                <div class="item" @click="downloadmusic">
                    <div class="icon"><img src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/tb10.png" alt="" /></div>
                    <p>下载</p>
                </div>
            </div>
            <audio
                class="audiobox"
                id="myAudios"
                :src="music"
                controls
                :name="musicinfo.titlename"
                :author="musicinfo.singer"
                :autoplay="isAutoPlay"
                @play="onPlay"
                @pause="onPause"
                @timeupdate="onTimeUpdate"
                ></audio>
        </div>
        <div class="discussbox" v-if="isdiscuss">
            <div class="bg" @click="changdiscuss"></div>
            <div class="discuss_content">
                <textarea v-model="content" maxlength="-1" placeholder="请输入您想说的话"></textarea>
                <div class="btnbox">
                    <div class="btn" @click="changdiscuss">取消</div>
                    <div class="btn" @click="publish">确定</div>
                </div>
            </div>
        </div>
        <div class="musiclistshow" v-if="ismusiclistshow">
            <div class="colselist" @click="changelist">X</div>
            <div class="listbox">
                <div class="listitem" v-for="(item,index) in musiclist" :key="index">
                    <p @click="handover(index)">{{item.titlename}}</p>
                    <div class="delete" @click="deletelistmusic(index)">X</div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import * as Api from "../../http/api";
export default {
	data() {
		return {
            userinfo: {},
            number: 0,
            ismusiclistshow: false, // 展示播放列表
            isdiscuss: false, // 展示评论框
            content: "",
            islove: false, // 是否喜欢
            timeinfo: {
                totalTime: 0, // 总时间长度
                nowTime: 0, // 当前时间长度
                showtotalTime: 0, // 展示总时间长度
                showtnowTime: 0 // 当前时间长度
            },
            musiclist: [], // 播放列表
            playtype: true, // 播放类型
            pointerStyle: "", // 动态样式
            isAutoPlay: false, // 是否播放
            musicinfo: {}, // 播放信息
			music: "",
            selectindex: null, // 选择
            audioCtx: null,
            timers: null,
            lovemusicinfo: {}, // 喜欢音乐信息
            isInitialization: 0 // 是否初始化
		}
	},
	onShow() {
        this.userinfo = wx.getStorageSync("userinfo");
        this.selectindex = wx.getStorageSync("musicoCurrent"); // 当前选择
        this.musiclist = wx.getStorageSync("musicolist");
        this.musicinfo = this.musiclist[this.selectindex];
        this.audioCtx = uni.createInnerAudioContext();
        this.audioCtx.src = this.musicinfo.url;
        this.audioCtx.autoplay = false;
        this.isAutoPlay = false;
        this.musicget();
    },
	methods: {
        // 获取喜欢列表
        async musicget() {
            const res = await Api.musicget(this.userinfo.username, 1)
            if (res.status) {
                res.data.forEach((item) => {
                    console.log(item.file_id, "数据请求");
                    console.log(this.musicinfo.file_id, "爬取数据");
                    if (Number(item.file_id) === this.musicinfo.file_id) {
                        this.islove = true;
                        this.lovemusicinfo = item;
                        return;
                    }
                })
            }
        },
        // 收藏/喜欢
        async collection(type) {
            console.log(this.musicinfo);
            const {singer, file_id, url, titlename} = this.musicinfo;
            const res = await Api.musicadd(this.userinfo.username, singer, file_id, url, type, titlename);
            if (res.status) {
                const alertmes = type === 1?"添加喜欢成功":"添加收藏成功";
                uni.showToast({
                    title: alertmes,
                    duration: 1000
                });
                this.musicget();
            } else {
                uni.showToast({
                    title: res.message,
                    duration: 1000
                });
            }
        },
        // 删除喜欢
        async musicdelete() {
            if (this.lovemusicinfo.id) {
                const res = await Api.musicdelete(this.lovemusicinfo.id, this.userinfo.username, 1);
                if (res.status) {
                    console.log("移除成功");
                    this.islove = false;
                }
            }
        },
        // 发布会话
        async publish() {
            console.log(this.content.length);
            if(this.content.length>0){
                const res = await Api.addMessage(
                    this.random(), // 会话编号
                    this.userinfo.username, // 发布人账户
                    this.userinfo.nickname, // 发布人昵称
                    this.musicinfo.titlename, // 发布对应音乐
                    this.getNowDate(), // 发布时间
                    this.content, // 发布内容
                    this.userinfo.user_pic
                )
                if (res.status) {
                    this.content = ""
                    this.showInput = false;
                    this.changdiscuss();
                    uni.showToast({
                        title: '信息发布成功',
                        duration: 1000
                    });
                } else {
                    this.changdiscuss();
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
        // 下载音乐
        downloadmusic() {
            const This = this;
            wx.downloadFile({
                url: This.musicinfo.url,
                success(res){
                    console.log(res);
                    if (res.statusCode === 200) {
                        wx.saveFile({
                            tempFilePath: res.tempFilePath,
                            success(res) {
                                wx.showToast({
                                    title: "下载成功",
                                    icon: "none",
                                    duratioon: 1000
                                })
                                const downmusic = wx.getStorageSync("downmusic") || [];
                                downmusic.forEach((item) => {
                                    if (item.file_downs === This.musicinfo.file_downs) {
                                        This.number -=1;
                                    } else {
                                        This.number +=1;
                                    }
                                });
                                console.log(This.number, downmusic.length);
                                if (This.number === downmusic.length) {
                                    downmusic.push(This.musicinfo);
                                    wx.setStorageSync("downmusic", downmusic);
                                }
                                This.number = 0
                            }
                        })
                        console.log("下载成功");
                    } else {
                        wx.showToast({
                            title: "下载失败",
                            icon: "none",
                            duratioon: 1000
                        })
                    }
                }
            })
        },
        // 切换
        handover(index) {
            this.selectindex = index;
            wx.setStorageSync("musicoCurrent", this.selectindex);
        },
        // 删除
        deletelistmusic(index) {
            console.log(this.musiclist);
            const id = this.musiclist[index].file_downs;
            this.musiclist = this.musiclist.filter(item => item.file_downs !== id);
            wx.setStorageSync("musicolist", this.musiclist);
        },
        changelist() {
            this.ismusiclistshow = !this.ismusiclistshow;
        },
        changdiscuss() {
            this.isdiscuss = !this.isdiscuss;
        },
        changelove() {
            if (!this.islove) {
                this.collection(1)
                this.islove = true;
            } else {
                this.musicdelete();
            }
        },
        // 切换播放类型
        chngepaytype() {
            this.playtype = !this.playtype;
        },
        // 上一首
        previous() {
            if(this.selectindex === 0) {
                this.selectindex = this.musiclist.length - 1;
            } else {
                this.selectindex -= 1;
            }
            this.paymusice();
        },
        // 下一首
        next() {
            if(this.selectindex === this.musiclist.length - 1) {
                this.selectindex = 0;
            } else {
                this.selectindex += 1;
            }
            this.paymusice();
        },
        paymusice() {
            this.pause();
            clearInterval(this.timers);
            this.isInitialization = 0;
            this.timeinfo = {
                totalTime: 0, // 总时间长度
                nowTime: 0, // 当前时间长度
                showtotalTime: 0, // 展示总时间长度
                showtnowTime: 0 // 当前时间长度
            }
            this.musicinfo = this.musiclist[this.selectindex];
            console.log(this.musicinfo);
            this.audioCtx.src = this.musicinfo.url;
            this.audioCtx.autoplay = false;
            this.isAutoPlay = false;
            this.play();
            this.onTimeUpdate();
        },
        playmusic() {
            if (!this.isAutoPlay) {
                console.log("播放");
                this.play();
                this.onTimeUpdate()
                this.pointerStyle = "pointer_plymusic1"
                const timer = setTimeout(() => {
                    this.pointerStyle = "pointeract"
                    clearTimeout(timer);
                }, 500)
            } else {
                console.log("停止");
                this.pause();
                clearInterval(this.timers);
                this.pointerStyle = "pointer_plymusic2"
                const timer = setTimeout(() => {
                    this.pointerStyle = ""
                    clearTimeout(timer);
                }, 500)
            }
            // this.isAutoPlay = !this.isAutoPlay;
        },
        play() {
			this.audioCtx.play();
			this.audioCtx.autoplay = true;
            this.isAutoPlay = true;

            const historymucic = wx.getStorageSync("historymucic") || [];
            historymucic.forEach((item) => {
                if (item.file_downs === this.musicinfo.file_downs) {
                    this.number -=1;
                } else {
                    this.number +=1;
                }
            });
            console.log(this.number, historymucic.length);
            if (this.number === historymucic.length) {
                historymucic.push(this.musicinfo);
                wx.setStorageSync("historymucic", historymucic);
            }
            this.number = 0
		},
		pause() {
			this.audioCtx.pause();
			this.audioCtx.autoplay = false;
            this.isAutoPlay = false;
		},
		stop() {
			this.audioCtx.stop();
			this.audioCtx.autoplay = false;
            this.isAutoPlay = false;
		},
        destroy() {
            this.audioCtx.destroy();
            this.isAutoPlay = false;
        },
		onPlay(event) {
			console.log('开始播放');
		},
		onPause(event) {
			console.log('暂停播放');
		},
		onTimeUpdate() {
            this.timers = setInterval(() => {
                // console.log("当前播放总时间：", this.audioCtx.duration);
                // console.log("当前播放进度：", this.audioCtx.currentTime);
                if (this.timeinfo.totalTime === this.timeinfo.nowTime && this.isInitialization > 1) {
                    clearInterval(this.timers);
                    this.isInitialization = 0;
                    if (this.playtype) {
                        this.next();
                    } else {
                        this.paymusice();
                    }
                }
                this.isInitialization += 1;
                this.timeinfo.totalTime = this.audioCtx.duration;
                this.timeinfo.nowTime = this.audioCtx.currentTime;
                this.timeinfo.showtotalTime = this.secondToMinutesAndSeconds(this.audioCtx.duration);
                this.timeinfo.showtnowTime = this.secondToMinutesAndSeconds(this.audioCtx.currentTime);
            }, 100)
		},
       secondToMinutesAndSeconds(timer) {
            const seconds = Math.floor(timer);
            const minutes = Math.floor(seconds / 60);
            const remainingSeconds = seconds % 60;
            const second = remainingSeconds < 10? "0" + remainingSeconds:remainingSeconds
            return minutes + ":" + second;
        }
    }
}
</script>
<style lang="less">
@import url("./index.less");
</style>