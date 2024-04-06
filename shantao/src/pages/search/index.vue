<template>
    <div class="serch">
        <div class="serchtop">
			<div class="icon"><img src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/serch.png" alt=""/></div>
			<input type="text" v-model="serchText" placeholder="歌曲搜索" />
            <div class="serchbtn" @click="getmusicList">搜索</div>
		</div>
        <div class="history" v-if="!serchData.length">
            <h3>搜索历史</h3>
            <div v-show="historyData.length" class="serchbox">
                <div class="serchitem" @click="serch(item)" v-for="(item,index) in historyData" :key="index">{{item.text}}</div>
            </div>
            <div class="historynone" v-show="!historyData.length">暂无更多搜索历史</div>
        </div>
        <div class="songlist" v-else>
            <h3>歌曲列表</h3>
            <div class="songbox" v-for="(item, index) in serchData" :key="index">
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
            selectindex: 0,
            serchText: "",
            showScreEning: false,
            Value: false,
            serchData: [],
            musicinfo: {
                url: "http://www.kumeiwp.com/sub/filestores/2023/05/01/b805646302e3b417ec44422d92626956.mp3",
                titlename: "测试数据",
                singer: "王力宏"
            }, // 音乐信息
            historyData: [
                {
                    text: "康定情歌"
                },
                {
                    text: "绣荷包的俏妹子"
                },
                {
                    text: "开门红"
                },
                {
                    text: "小红桃"
                },
                {
                    text: "茉莉花"
                }
            ]
		}
	},
	mounted() {
        
    },
	methods: {
        playmusic(item, index) {
            this.showScreEning = true;
            this.Value = !this.Value;
            this.selectindex = index;
            this.musicinfo = item;
        },
        serch(item) {
            this.serchText = item.text;
            this.getmusicList();
        },
        async getmusicList() {
            const response = await Api.getSongData(this.serchText, 1, 20);
            if (!response.data.length) {
                wx.showToast({
                    title: "没有更多啦！",
                    icon: "none",
                    duratioon: 1000
                })
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
                    this.serchData.push(item);
                }
            });
            if(this.serchData.length < 20) {
                this.getmusicList();
            }
            console.log(this.serchData);
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
            this.musicinfo = this.serchData[this.selectindex];
        },
        next() {
            if (this.selectindex === this.serchData.length - 1) {
                this.selectindex = 0;
            } else {
                this.selectindex += 1;
            }
            this.showScreEning = true;
            this.Value = !this.Value;
            this.musicinfo = this.serchData[this.selectindex];
        }
	}
}
</script>
<style lang="less">
@import url("./style/index.less");
</style>