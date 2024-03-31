<template>
    <div>
        <web-view :src="gourl"></web-view>
    </div>
</template>
<script>
export default {
	data() {
		return {
			gourl: ""
		}
	},
	mounted() {
        this.gourl = decodeURIComponent(this.$root.$mp.query.gourl)
    }
}
</script>