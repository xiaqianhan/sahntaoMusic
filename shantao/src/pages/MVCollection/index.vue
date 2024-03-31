<template>
    <div class="mvCollection">
        <div class="mvbox" v-for="(item, index) in mvdata" :key="index">
            <div class="top">
                <div class="icon"><img :src="item.avatar" alt=""></div>
                <div class="info">
                    <h3>{{item.title}}</h3>
                    <p>{{item.singer}}</p>
                </div>
            </div>
            <div class="boxicon" @click="goUrl(item.url)">
                <div class="playmv"><img src="../../static/pages/mvicon/playmv.png" alt=""></div>
                <img :src="item.poster" alt="">
            </div>
        </div>
    </div>
</template>
<script>
import configData from "./config";
export default {
	data() {
		return {
            mvdata: configData.data.slice(0, 10)
		}
	},
	onLoad() {

	},
	methods: {
        goUrl(url) {
			wx.navigateTo({
                url: "/pages/webview/index?gourl=" + encodeURIComponent(url)
            })
		}
	}
}
</script>
<style lang="less">
@import url("./index.less");
</style>