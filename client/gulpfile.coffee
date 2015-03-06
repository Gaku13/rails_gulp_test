
gulp         = require 'gulp'
sass         = require 'gulp-sass'
sourceMaps   = require "gulp-sourcemaps"
autoPrefixer = require "gulp-autoprefixer"
liveReload   = require "gulp-livereload"
filter       = require "gulp-filter"
coffee       = require "gulp-coffee"
concat       = require "gulp-concat"
rename       = require "gulp-rename"
minifyCSS    = require "gulp-minify-css"
revAll       = require "gulp-rev-all"
plumber      = require "gulp-plumber"


coffeeFilter = filter ["**/*.coffee"]


gulp.task "default", ["js", "sass", "images", "fonts"]

gulp.task "js", ->
  gulp.src("javascripts/**/*")
    .pipe(sourceMaps.init())
    .pipe(coffeeFilter)
    .pipe(coffee())
    .pipe(coffeeFilter.restore())
    .pipe(concat("application.js"))
    .pipe(sourceMaps.write("."))
    .pipe(gulp.dest("../public/javascripts"))
    .pipe(liveReload())


gulp.task "sass", ->
  gulp.src("stylesheets/application.css.scss")
    .pipe(sourceMaps.init())
    .pipe(sass({includePaths: "asset/", sourceComments: true, errLogToConsole: true}))
    .pipe(autoPrefixer())
    .pipe(rename("application.css"))
    .pipe(sourceMaps.write("."))
    .pipe(gulp.dest("../public/stylesheets"))
    .pipe(liveReload())


gulp.task "images", ->
  gulp.src("images/**/*")
    .pipe(gulp.dest("../public/assets/images/"))
    .pipe(liveReload())


gulp.task "fonts", ->
  gulp.src("fonts/**/*")
    .pipe(gulp.dest("../public/assets/fonts/"))
    .pipe(liveReload())


gulp.task "reload", ["watch", "js", "sass", "images", "fonts"]


gulp.task "watch", ->
  liveReload.listen
  gulp.watch "stylesheets/*", { interval: 500 }, ["sass"]
  gulp.watch "javascripts/*",  { interval: 500 }, ["js"]
