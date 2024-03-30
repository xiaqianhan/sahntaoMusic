<template>
    <div class="shiyan">
        <button @click="getlocation">获取定位</button>
        <p>定位经度：{{positioning.x}}</p>
        <p>定位维度：{{positioning.y}}</p>
        <button @click="lookCode">扫码</button>
        <p>扫码类型：{{codeObj.type}}</p>
        <p>扫码内容：{{codeObj.content}}</p>
        <button type="primary" @click="choseImg">图片上传</button>
        <div>
            <image v-if="iconurl" :src="iconurl" alt="" ></image>
            <p v-else>暂无图</p>
        </div>
    </div>
</template>
<script>
import * as Api from "../../http/api";
export default {
    data () {
        return {
            positioning: {
                x:"初始0",
                y:"初始0"
            },
            codeObj: {
                type: "初始数据",
                content: "初始数据"
            },
            iconurl: ""
        }
    },
    async mounted() {
        console.log("11111111111");
        const res = await Api.ceshi();
        console.log(res);
    },
    methods: {
        getlocation() {
            const This = this;
            wx.getLocation({
                type: 'wgs84',
                success: function (res) {
                    This.positioning.x = res.longitude;
                    This.positioning.y = res.latitude;
                    console.log('当前位置的经度：' + res.longitude);
                    console.log('当前位置的纬度：' + res.latitude);
                }
            })
        },
        lookCode() {
            const This = this;
            uni.scanCode({
                success: function(res) {
                    This.codeObj.type = res.scanType;
                    This.codeObj.content = res.result
                    console.log('条码类型：' + res.scanType);
		            console.log('条码内容：' + res.result);
                }
            })
        },
        choseImg() {
            const This = this;
            uni.chooseImage({
                sourceType: ['album'], //从相册选择
                success: function (res) {
                    console.log(res.tempFilePaths);
                    This.iconurl = JSON.stringify(res.tempFilePaths[0]);
                }
            });
        }
    }
}
</script>
<style lang="less">
@import url("./style/index.less");
</style>