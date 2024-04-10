<template>
    <div class="musicList">
        <div class="musilistbox">
			<div class="musicitem" v-for="(item,index) in musicListdata" @longpress="deleteItem(item, index)" :key="index">
				<div class="info">
					<h3>{{item.titlename}}</h3>
					<p>{{item.singer}}</p>
				</div>
				<div class="icon" @click="playmusic(item, index)"><img src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/tb34.png" alt="" /></div>
			</div>
		</div>
		<ScreEning v-if="showScreEning" @gomusicinfo="gomusicinfo" :Value="Value" :musicinfo="musicinfo" @previous="previous" @next="next"></ScreEning>
    </div>
</template>
<script>
import * as Api from "../../http/api";
import ScreEning from "../../compoment/screening/idnex.vue";
export default {
	components: {
        ScreEning
    },
	data() {
		return {
			selectindex: 0,
			showScreEning: false,
            Value: false,
			musicinfo: {
                url: "http://www.kumeiwp.com/sub/filestores/2023/05/01/b805646302e3b417ec44422d92626956.mp3",
                titlename: "测试数据",
                singer: "王力宏"
            }, // 音乐信息

			storename: "",
			listtype: 0,
            userinfo: {},
			musicListdata: [] // 音乐列表
		}
	},
	onShow() {
		// downmusic: 下载列表
		// musicolist: 歌单
		// historymucic: 最近播放
		// collection: 收藏
		// likemusic: 我的喜欢
		this.userinfo = wx.getStorageSync("userinfo");
		const newtitle = decodeURIComponent(this.$root.$mp.query.title);
		const type = Number(this.$root.$mp.query.type);
		this.listtype = type;
		const enums = {
			1: "collection",
			2: "likemusic",
			3: "historymucic",
			4: "downmusic",
			5: "musicolist"
		}
		const storename = enums[type];
		this.storename = storename;
		if (type === 1 || type === 2) {
			console.log("我的收藏/喜欢");
			this.musicget(type);
		} else {
			this.musicListdata = wx.getStorageSync(storename);
		}
        wx.setNavigationBarTitle({
            title: newtitle
        })
	},
	mounted() {
	},
	methods: {
		playmusic(item, index) {
			console.log("1111111");
            wx.setStorageSync("musicolist", this.musicListdata);
            this.showScreEning = true;
            this.Value = !this.Value;
            this.selectindex = index;
            this.musicinfo = item;
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
            this.musicinfo = this.musicListdata[this.selectindex];
        },
		next() {
            if (this.selectindex === this.songData.length - 1) {
                this.selectindex = 0;
            } else {
                this.selectindex += 1;
            }
            this.showScreEning = true;
            this.Value = !this.Value;
            this.musicinfo = this.musicListdata[this.selectindex];
        },
		gomusicinfo() {
            wx.setStorageSync("musicoCurrent", this.selectindex); // 当前选择
            wx.navigateTo({
                url: "/pages/musicinfo/index"
            })
        },
		deleteItem(item, index) {
			const This = this;
			wx.showModal({
            	title: "提示",
				content: "是否将此歌曲移除列表",
				confirmColor: "#f00",
				async success(res) {
					if(res.confirm){
						console.log("点击了确认");
						if (This.listtype === 1 || This.listtype === 2) {
							This.musicdelete(item.id, This.listtype)
						} else {
							This.musicListdata = This.musicListdata.splice(index, 1)
							wx.setStorageSync(This.storename, This.musicListdata);
						}
					}
				}
			});
		},
		// 获取喜欢列表
        async musicget(type) {
            const res = await Api.musicget(this.userinfo.username, type)
            if (res.status) {
                this.musicListdata = res.data;
            }
        },
		// 删除喜欢
        async musicdelete(id, type) {
			const res = await Api.musicdelete(id, this.userinfo.username, type);
			if (res.status) {
				console.log("移除成功");
				this.musicget(type)
				uni.showToast({
					title: "移除成功",
					duration: 1000
				});
			}
        }
	}
}
</script>
<style lang="less">
@import url("./index.less");
</style>