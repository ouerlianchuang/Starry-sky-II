var gulp = require("gulp")
	uglify = require("gulp-uglify")
	coffee = require("gulp-coffee")
	concat = require("gulp-concat")

var paths = {
	scripts : ["js/*.coffee"]
}

gulp.task("coffee",function(){
	gulp.src(paths.scripts)
		.pipe(coffee({bare:true}))
		// .pipe(uglify())
		// .pipe(concat('all.min.js'))
		.pipe(gulp.dest("build"))
})
gulp.task("watch",function(){
	gulp.watch(paths.scripts,['coffee']);
})