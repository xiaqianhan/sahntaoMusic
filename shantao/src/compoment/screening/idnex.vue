<template>
    <div class="screening">
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
        <div class="playMasking">
            <div class="playMasking_lef" @click="goview">
                <div class="icon">
                    <img :class="isAutoPlay?'rotateimg':''" src="http://p2.music.126.net/go9IapEBzVE5oUAa90IO3Q==/109951169313536434.jpg?param=177y177" alt="">
                </div>
                <div class="info">
                    <h3>{{musicinfo.titlename}}</h3>
                    <p>{{musicinfo.singer}}</p>
                </div>
            </div>
            <div class="playMasking_rig">
                <div class="previous" @click="previous">
                    <img src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/previous.png" alt="">
                </div>
                <div class="playbtn">
                    <!-- <button @click="play">播放</button>
                    <button @click="pause">暂停</button>
                    <button @click="stop">停止</button> -->
                    <button @click="play" v-if="!isAutoPlay"><img src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/playopen.png" alt=""></button>
                    <button @click="pause" v-else><img src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/playstop.png" alt=""></button>
                </div>
                <div class="next" @click="next">
                    <img src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/next.png" alt="">
                </div>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    props: {
        Value: Boolean, // 变更
        musicinfo: Object
    },
    watch: {
        Value (val) {
            // 发送成功就执行倒计时
            this.pause();
            this.audioCtx.src = this.musicinfo.url;
            this.audioCtx.autoplay = true;
            this.isAutoPlay = true;
            this.play();
        },
    },
    data() {
        return {
            number: 0,
            music: this.musicinfo.url,
            audioCtx: null,
            isAutoPlay: false
        }
    },
    mounted() {
        console.log(this.musicinfo);
        // 初始化InnerAudioContext实例
        this.audioCtx = uni.createInnerAudioContext();
        this.audioCtx.src = this.music;
        this.audioCtx.autoplay = false;
        this.isAutoPlay = false;
        // this.audioCtx.autoplay = true;
        // this.isAutoPlay = true;
    },
    methods: {
        goview() {
            this.$emit("gomusicinfo")
        },
        previous() {
            this.$emit("previous")
        },
        next() {
            this.$emit("next")
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
		onTimeUpdate(event) {
			console.log('当前播放进度：', event.detail.currentTime);
		}
    },
}
</script>
<style lang="less">
@import url("./index.less");
</style>