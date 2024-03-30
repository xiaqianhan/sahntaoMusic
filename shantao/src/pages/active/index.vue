<template>
    <div class="square">
        活动
        <TabBar actIndex="1"></TabBar>
    </div>
</template>
<script>
import TabBar from "../../compoment/tebBar.vue"
export default {
    components: {
        TabBar
    },
	data() {
		return {
			title: 'Hello'
		}
	},
	onLoad() {

	},
	methods: {

	}
}
</script>
<style lang="less">
@import url("./style/index.less");
</style>