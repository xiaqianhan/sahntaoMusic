<template>
    <div class="musicList">
        <div class="musilistbox">
			<div class="musicitem" v-for="(item,index) in musicListdata" :key="index">
				<div class="info">
					<h3>{{item.titlename}}</h3>
					<p>{{item.singer}}</p>
				</div>
				<div class="icon"><img src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/tb34.png" alt="" /></div>
			</div>
		</div>
    </div>
</template>
<script>
export default {
	data() {
		return {
			musicListdata: [] // 音乐列表
		}
	},
	onShow() {
		// downmusic: 下载列表
		// musicolist: 歌单
		// historymucic: 最近播放
		// collection: 收藏
		// likemusic: 我的喜欢
		const newtitle = decodeURIComponent(this.$root.$mp.query.title);
		const type = Number(this.$root.$mp.query.type);
		const enums = {
			1: "collection",
			2: "likemusic",
			3: "historymucic",
			4: "downmusic",
			5: "musicolist"
		}
		const storename = enums[type];
		this.musicListdata = wx.getStorageSync(storename);
        wx.setNavigationBarTitle({
            title: newtitle
        })
	},
	mounted() {
	},
	methods: {

	}
}
</script>
<style lang="less">
@import url("./index.less");
</style>