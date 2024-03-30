<template>
    <div class="bable">
        <div v-for="(item, index) in itemList" :key="index">
            <div class="itembox">
                <div class="icon" v-if="actIndex === index">
                    <img :src="item.imgact" alt="">
                </div>
                <div class="icon" @click="goUrl(item.url)" v-else>
                    <img :src="item.img" alt="">
                </div>
                <p :class="actIndex === index?'act':''">{{item.text}}</p>
            </div>
        </div>
        
    </div>
</template>
<script>
export default {
    props: {
        actIndex: Number
    },
    data() {
        return {
            itemList: [{
                text: "首页",
                img: require("../static/compoment/tabBar/home.png"),
                imgact: require("../static/compoment/tabBar/homeact.png"),
                url: "/pages/home/index"
            },{
                text: "活动",
                img: require("../static/compoment/tabBar/activity.png"),
                imgact: require("../static/compoment/tabBar/activityact.png"),
                url: "/pages/active/index"
            },{
                text: "广场",
                img: require("../static/compoment/tabBar/square.png"),
                imgact: require("../static/compoment/tabBar/squareact.png"),
                url: "/pages/square/index"
            },{
                text: "我的",
                img: require("../static/compoment/tabBar/usercenter.png"),
                imgact: require("../static/compoment/tabBar/usercenteract.png"),
                url: "/pages/usercenter/index"
            }]
        }
    },
    methods: {
        goUrl(url) {
            wx.reLaunch({
                url
            })
        }
    },
}
</script>
<style lang="less">
.bable{
    position: fixed;
    bottom: 0;
    left: 0;
    height: 8vh;
    width: 100%;
    background-color: white;
    border-top: 0.3vw solid #b3b1b1;
    display: flex;
    justify-content: space-around;
    align-items: center;
    .itembox{
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        .icon{
            width: 6.5vw;
            height: 6.5vw;
            // background-color: aqua;
            margin-bottom: 1vw;
            img{
                width: 100%;
                height: 100%;
            }
        }
        p{
            color: #878686;
            font-size: 3.2vw;
        }
        .act{
            font-weight: 600;
            color: #1296db;
        }
    }
}
</style>