<template>
    <div class="songsheet">
        <div class="top">
            <div class="left">
                <div class="iconbox">
                    <img src="https://p1.music.126.net/OrXO5yyb3SHJyZWNfCnbfw==/109951163676024440.jpg?imageView=1&type=webp&thumbnail=379x0" alt="">
                </div>
                <div class="lab">歌单</div>
                <div class="number">
                    <div class="icons"><img src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/headset.png" alt=""></div>
                    <p>2656.8万</p>
                </div>
            </div>
            <div class="right">
                <h3>若是心怀旧梦 就别再无疾而终</h3>
                <div class="namebox">
                    <div class="icon"><img src="https://p1.music.126.net/F9Lv__xnYprJ1NgoiaQlew==/109951163929365232.jpg?imageView=1&type=webp&thumbnail=91x0" alt=""></div>
                    <p>与你赴海</p>
                </div>
            </div>
        </div>
        <div class="songlist">
            <h3>歌曲列表</h3>
            <div class="songbox" v-for="(item, index) in songData" :key="index">
                <div class="itembox" @click="playmusic(item, index)">
                    <div class="item_lef">
                        <p class="num">{{index +1}}</p>
                        <div class="song_info">
                            <h4>{{item.titlename}}</h4>
                            <p>{{item.singer}}</p>
                        </div>
                    </div>
                    <div class="icon"><img src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/tb34.png" alt=""></div>
                </div>
            </div>
        </div>
        <ScreEning v-if="showScreEning" :Value="Value" :musicinfo="musicinfo" @previous="previous" @next="next"></ScreEning>
    </div>
</template>
<script>
import ScreEning from "../../compoment/screening/idnex.vue";
import * as Api from "../../http/api";
export default {
    components: {
        ScreEning
    },
	data() {
		return {
            page: 1,
            isBottom: false,
            isTop: false,
            showScreEning: false,
            Value: false,
            selectindex: 0,
            type: "",
            musicinfo: {
                url: "http://www.kumeiwp.com/sub/filestores/2023/05/01/b805646302e3b417ec44422d92626956.mp3",
                titlename: "测试数据",
                singer: "王力宏"
            }, // 音乐信息
            songData: []
		}
	},
	onShow() {
        const newtitle = decodeURIComponent(this.$root.$mp.query.title);
        this.type = newtitle;
        wx.setNavigationBarTitle({
            title: newtitle
        })
        this.getmusicList();
    },
	methods: {
        playmusic(item, index) {
            this.showScreEning = true;
            this.Value = !this.Value;
            this.selectindex = index;
            this.musicinfo = item;
        },
        async getmusicList() {
            const response = await Api.getSongData(this.type, this.page, 100);
            if (!response.data.length) {
                if(this.isBottom || this.isTop) {
                    wx.showToast({
                        title: "没有更多啦！",
                        icon: "none",
                        duratioon: 1000
                    })
                }
                return;
            }
            response.data.forEach(async (item) => {
                if (item.title.indexOf('mp4') > 0) {
                    item.titlename = "";
                } else {
                    item.titlename = this.sliceString(item.title, 'title="', '.mp3').replace(/\s/g, "");
                }
                if(item.titlename.length < 20 && item.titlename) {
                    const res = await Api.getactData(item.file_id);
                    item.url = this.sliceMp3(res);
                    if (item.titlename.indexOf("-") > 0) {
                        item.singer = item.titlename.split('-')[0];
                        item.titlename = item.titlename.slice(item.singer.length + 1)
                    }
                    this.songData.push(item);
                }
            });
            if(this.songData.length < 20 && this.page <= 10) {
                this.page += 1;
                this.getmusicList();
            }
            console.log(this.songData);
        },

        onPullDownRefresh() {
            setTimeout(() => {
                wx.stopPullDownRefresh();
                // this.getShopList();
                this.page += 1;
                this.getmusicList();
                this.isTop = true
            }, 500);
        },

        onReachBottom() {
            this.isBottom = true;
            this.page += 1;
            this.getmusicList();
        },
        
        sliceString(string, str1, str2) {
            const number1 = string.indexOf(str1);
		    const strtext = string.slice(number1);
            const number2 = strtext.indexOf(str2);
		    return strtext.slice(str1.length, number2)
        },
        sliceMp3(response) {
            const str = '<div  class="wai3" style="overflow-wrap: break-word;">'
            const strtext = String(response);
            const number1 = strtext.indexOf(str);
            const strtexts = strtext.slice(number1);
            const number2 = strtexts.indexOf("http");
            const number3 = strtexts.indexOf("</div>");
            return strtexts.slice(number2, number3);
        },
        previous() {
            if (this.selectindex === 0) {
                return wx.showToast({
                    title: "已经是第一首了哦",
                    icon: "none",
                    duratioon: 1000
                })
            }
            this.selectindex -= 1;
            this.showScreEning = true;
            this.Value = !this.Value;
            this.musicinfo = this.songData[this.selectindex];
        },
        next() {
            if (this.selectindex === this.songData.length - 1) {
                this.selectindex = 0;
            } else {
                this.selectindex += 1;
            }
            this.showScreEning = true;
            this.Value = !this.Value;
            this.musicinfo = this.songData[this.selectindex];
        }
	}
}
</script>
<style lang="less">
@import url("./style/index.less");
</style>