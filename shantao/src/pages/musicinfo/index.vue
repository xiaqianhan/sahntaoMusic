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
                <div class="item">
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
export default {
	data() {
		return {
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
            isInitialization: 0 // 是否初始化
		}
	},
	mounted() {
        this.selectindex = wx.getStorageSync("musicoCurrent"); // 当前选择
        this.musiclist = wx.getStorageSync("musicolist");
        this.musicinfo = this.musiclist[this.selectindex];
        this.audioCtx = uni.createInnerAudioContext();
        this.audioCtx.src = this.musicinfo.url;
        this.audioCtx.autoplay = false;
        this.isAutoPlay = false;
    },
	methods: {
        // 下载音乐
        downloadmusic() {
            wx.downloadFile({
                url: this.musicinfo.url,
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
        publish() {
            // 发布
            this.changdiscuss();
        },
        changdiscuss() {
            this.isdiscuss = !this.isdiscuss;
        },
        changelove() {
            this.islove = !this.islove;
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