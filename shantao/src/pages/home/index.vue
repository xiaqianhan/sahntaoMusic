<template>
    <div class="home">
        <div class="serch">
			<div class="icon"><img src="http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/serch.png" alt=""/></div>
			<input type="text" placeholder="歌曲搜索" />
		</div>
		<div class="swp">
            <swiper
                indicator-dots="true"
                autoplay="true"
                circular="true"
                indicator-color="#99999950"
                indicator-active-color="#FFFFFF"
                interval="2000"
            >
                <swiper-item v-for="(item, index) in swperdata" :key="index">
                    <div class="itembox">
                        <image :src="item.icon"></image>
                    </div>
                </swiper-item>
            </swiper>
        </div>
		<div class="recommendation">
			<div class="recommendation_box" v-for="(item, index) in recommendationdata" :key="index">
				<div class="itembox" @click="goview(item)">
					<div class="icon"><img :src="item.icon" alt=""></div>
					<p>{{item.title}}</p>
				</div>
			</div>
		</div>
		<div class="broadcast">
			<h3>热播歌曲</h3>
			<div class="broadcastbox">
				<div class="icon" @click="goUrl('https://music.163.com/#/playlist?id=6630486540')">
					<img src="http://p2.music.126.net/zpmOTZw533nltCQJtXC8Rg==/109951168215962168.jpg?param=140y140" alt="">
					<p>国语珍藏 | 给你一张过去的CD</p>
				</div>
				<div class="icon" @click="goUrl('https://music.163.com/#/playlist?id=6630486540')">
					<img src="http://p1.music.126.net/VWUg6fu4AjtCnmsbGUUBog==/109951168605372710.jpg?imageView=1&thumbnail=800y800&enlarge=1%7CimageView=1&watermark&type=1&image=b2JqL3c1bkRrTUtRd3JMRGpEekNtOE9tLzMxNjg5NTQ2OTkxL2Y4ZjYvMjAyMzEwMjMxNjUyMjMveDg1NzE3MDA3Mjk1NDMxMzcucG5n&dx=0&dy=0%7Cwatermark&type=1&image=b2JqL3dvbkRsc0tVd3JMQ2xHakNtOEt4LzI3NjEwNDk3MDYyL2VlOTMvOTIxYS82NjE4LzdhMDc5ZDg0NTYyMDAwZmVkZWJmMjVjYjE4NjhkOWEzLnBuZw==&dx=0&dy=0%7CimageView=1&thumbnail=140y140&?param=140y140" alt="">
					<p>凯尔特民谣 | 美妙奇异的凯尔特世界</p>
				</div>
			</div>
		</div>
		<div class="classification">
			<h3>歌曲分类</h3>
			<div class="classificationbox">
				<div class="content" v-for="(item, index) in classificationdata" :key="index">
					<div class="itebox" @click="goSongsheet(item)">
						<div class="icon"><img :src="item.icon" alt=""></div>
						<p>{{item.title}}</p>
					</div>
				</div>
				
			</div>
		</div>
        <TabBar actIndex="0"></TabBar>
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
			gourl: "https://music.163.com/#/playlist?id=6630486540",
			swperdata: [
                {
                    icon: "http://www.xiastyq.top/cqmp_test/shantaoMusic/findmusic/1image1.jpg"
                },
                {
                    icon: "http://www.xiastyq.top/cqmp_test/shantaoMusic/findmusic/1image2.jpg"
                },
                {
                    icon: "http://www.xiastyq.top/cqmp_test/shantaoMusic/findmusic/1image3.jpg"
                },
                {
                    icon: "http://www.xiastyq.top/cqmp_test/shantaoMusic/findmusic/1image4.jpg"
                },
                {
                    icon: "http://www.xiastyq.top/cqmp_test/shantaoMusic/findmusic/1image5.jpg"
                },
                {
                    icon: "http://www.xiastyq.top/cqmp_test/shantaoMusic/findmusic/1image6.jpg"
                },
                {
                    icon: "http://www.xiastyq.top/cqmp_test/shantaoMusic/findmusic/2image7.jpg"
                },
                {
                    icon: "http://www.xiastyq.top/cqmp_test/shantaoMusic/findmusic/2image8.jpg"
                }
            ],
			recommendationdata: [
				{
					title: "每日推荐",
					icon: "http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/tb27.png",
					url: "/pages/songsheet/index?title=" + encodeURIComponent("推荐")
				},{
					title: "歌单",
					icon: "http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/tb13.png",
					url: "/pages/songsheet/index?title=" + encodeURIComponent("华语")
				},{
					title: "排行榜",
					icon: "http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/ranking .png",
					url: "/pages/songsheet/index?title=" + encodeURIComponent("排行")
				},{
					title: "MV",
					icon: "http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/tb23.png",
					url: "/pages/MVCollection/index"
				}
			],
			classificationdata: [
				{
					title: "山歌",
					icon: "http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/tb28.png"
				},{
					title: "号子",
					icon: "http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/tb29.png"
				},{
					title: "小调",
					icon: "http://www.xiastyq.top/cqmp_test/shantaoMusic/icon/tb29.png"
				}
			]
		}
	},
	onLoad() {

	},
	methods: {
		goUrl(url) {
			wx.navigateTo({
                url: "/pages/webview/index?gourl=" + encodeURIComponent(url)
            })
		},
		goSongsheet(item) {
			wx.navigateTo({
                url: "/pages/songsheet/index?title=" + encodeURIComponent(item.title)
            })
		},
		goview(item) {
			wx.navigateTo({
                url: item.url
            })
		} 
	}
}
</script>
<style lang="less">
@import url("./style/index.less");
</style>