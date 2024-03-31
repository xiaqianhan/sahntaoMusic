<template>
    <div class="square">
        音乐列表
        <ScreEning :musicinfo="musicinfo" @></ScreEning>
    </div>
</template>
<script>
import ScreEning from "../../compoment/screening/idnex.vue";
export default {
    components: {
        ScreEning
    },
	data() {
		return {
            musicinfo: {
                src: "http://www.kumeiwp.com/sub/filestores/2023/05/01/b805646302e3b417ec44422d92626956.mp3",
                title: "测试数据",
                name: "王力宏"
            }, // 音乐信息
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