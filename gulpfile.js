 var gulp = require("gulp")
	uglify = require("gulp-uglify")
	coffee = require("gulp-coffee")
	concat = require("gulp-concat")

var paths = {
	scripts : ["js/common.coffee", "js/init.coffee", "js/update.coffee", "js/render.coffee", "js/loop.coffee", "js/lib.coffee"]
}

gulp.task("coffee",function(){
	gulp.src(paths.scripts)
		.pipe(coffee({bare:true}))
		// bare:true coffee转义不默认闭包模式
		.pipe(uglify())
		.pipe(concat('all.min.js'))
		.pipe(gulp.dest("build"))
})
gulp.task("watch",function(){
	gulp.watch(paths.scripts,['coffee']);
})