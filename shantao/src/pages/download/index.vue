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
		const newtitle = decodeURIComponent(this.$root.$mp.query.title);
        wx.setNavigationBarTitle({
            title: newtitle
        })
	},
	mounted() {
		this.musicListdata = wx.getStorageSync("musicolist");
		console.log(this.musicListdata);
	},
	methods: {

	}
}
</script>
<style lang="less">
@import url("./index.less");
</style>