<template>
    <div class="active">
        <div v-for="(item,index) in activeData" :key="index">
            <div class="activebox" :style="{backgroundColor : fontBackColor[index > 4?(index-(parseInt(index/5)*5)):index]}" @click="godetails(item.url)">
                <div class="activebox-top">
                    <h3>{{item.title}}</h3>
                </div>
                <div class="activebox-botton">
                    <div class="botton-left">
                        <h4>{{item.time}}</h4>
                        <p>地点：{{item.address}}</p>
						<p>价格：{{item.price}}</p>
                    </div>
                    <div class="botton-right">
                        <image src="../../static/pages/mvicon/active/see.png"></image>
                    </div>
                </div>
            </div>
        </div>
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
			qwurl: "",
			isAutoPlay: false,
			audioCtx: null,
			fontBackColor: ['#D5FB94', '#B4FDFF', '#F7F392', '#5FC3C4', '#C499FB'],
			activeData: [
				{
					title:"【8折早鸟票】梦系红楼——红楼梦全版主题演唱音乐会",
					time: "2024.05.01 周三 19:30",
					address: "北京 | 北京音乐厅",
					price: "144-580 元",
					url: "https://detail.damai.cn/item.htm?spm=a2oeg.search_category.0.0.5a3e4d15aKNExf&id=769949903122&clicktitle=%E3%80%908%E6%8A%98%E6%97%A9%E9%B8%9F%E7%A5%A8%E3%80%91%E6%A2%A6%E7%B3%BB%E7%BA%A2%E6%A5%BC%E2%80%94%E2%80%94%E7%BA%A2%E6%A5%BC%E6%A2%A6%E5%85%A8%E7%89%88%E4%B8%BB%E9%A2%98%E6%BC%94%E5%94%B1%E9%9F%B3%E4%B9%90%E4%BC%9A"
				},
				{
					title:"【北京】 故乡的原风景-宗次郎2024个人音乐会北京站",
					time: "2024.04.19 周五 19:30",
					address: "北京 | 北京展览馆剧场",
					price: "99-1560 元",
					url: "https://detail.damai.cn/item.htm?spm=a2oeg.search_category.0.0.5a3e4d15l3aJD2&id=764861680461&clicktitle=%E6%95%85%E4%B9%A1%E7%9A%84%E5%8E%9F%E9%A3%8E%E6%99%AF-%E5%AE%97%E6%AC%A1%E9%83%8E2024%E4%B8%AA%E4%BA%BA%E9%9F%B3%E4%B9%90%E4%BC%9A%E5%8C%97%E4%BA%AC%E7%AB%99"
				},
				{
					title:"【北京】 故乡的原风景-宗次郎2024个人音乐会北京站",
					time: "2024.04.19 周五 19:30",
					address: "北京 | 北京展览馆剧场",
					price: "99-1560 元",
					url: "https://detail.damai.cn/item.htm?spm=a2oeg.search_category.0.0.5a3e4d15l3aJD2&id=764861680461&clicktitle=%E6%95%85%E4%B9%A1%E7%9A%84%E5%8E%9F%E9%A3%8E%E6%99%AF-%E5%AE%97%E6%AC%A1%E9%83%8E2024%E4%B8%AA%E4%BA%BA%E9%9F%B3%E4%B9%90%E4%BC%9A%E5%8C%97%E4%BA%AC%E7%AB%99"
				},
				{
					title:"【重庆】一生所爱——经典浪漫电影主题音乐会",
					time: "2024.04.06 周六 19:30",
					address: "重庆市 | 重演时代艺术中心 ",
					price: "33-298 元",
					url: "https://detail.damai.cn/item.htm?spm=a2oeg.search_category.0.0.5a3e4d15l3aJD2&id=765604380834&clicktitle=%E4%B8%80%E7%94%9F%E6%89%80%E7%88%B1%E2%80%94%E2%80%94%E7%BB%8F%E5%85%B8%E6%B5%AA%E6%BC%AB%E7%94%B5%E5%BD%B1%E4%B8%BB%E9%A2%98%E9%9F%B3%E4%B9%90%E4%BC%9A"
				}
			]
		}
	},
	async mounted() {
	},
	methods: {
		godetails(url) {
			wx.navigateTo({
                url: "/pages/webview/index?gourl=" + encodeURIComponent(url)
            })
		}
	}
}
</script>
<style lang="less">
@import url("./style/index.less");
</style>