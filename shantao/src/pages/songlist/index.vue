<template>
    <div class="square">
        音乐列表
    </div>
</template>
<script>
export default {
	data() {
		return {
			title: 'Hello'
		}
	},
	mounted() {
        const typetitle = {
            1: "我的收藏",
            2: "我的喜欢",
            3: "最近播放"
        }
        const newtitle = typetitle[this.$root.$mp.query.type];
        wx.setNavigationBarTitle({
            title: newtitle
        })
    },
	methods: {

	}
}
</script>
<style lang="less">
@import url("./style/index.less");
</style>