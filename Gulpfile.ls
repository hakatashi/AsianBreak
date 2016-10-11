require! {
  gulp
  browserify
  \vinyl-source-stream
  \gulp-livescript
  \gulp-rename
  \lcov-sourcemap
}

if process.env.TRAVIS_NODE_VERSION isnt '0.12'
  gulp-sourcemaps = require \gulp-sourcemaps

gulp.task \livescript ->
  if process.env.TRAVIS_NODE_VERSION isnt '0.12'
    gulp.src <[*.ls test/*.ls !browser.ls !Gulpfile.ls]> base: \.
    .pipe gulp-sourcemaps.init!
    .pipe gulp-livescript!
    .pipe gulp-sourcemaps.write \.
    .pipe gulp.dest \.
  else
    gulp.src <[*.ls test/*.ls !browser.ls !Gulpfile.ls]> base: \.
    .pipe gulp-livescript!
    .pipe gulp.dest \.

gulp.task \browserify ->
  browserify \browser.ls do
    transform: <[browserify-livescript]>
  .bundle!
  .pipe vinyl-source-stream \browser.js
  .pipe gulp.dest \.

gulp.task \transform-lcov ->
  lcov-sourcemap.write-lcov do
    \lcov-raw.info
    \index.js.map
    \.
    \lcov.info

gulp.task \build, <[livescript browserify]>

gulp.task \default, <[build]>
