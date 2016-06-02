require! {
  gulp
  browserify
  \vinyl-source-stream
  \gulp-livescript
  \gulp-rename
  \gulp-sourcemaps
  \lcov-sourcemap
}

gulp.task \build ->
  gulp.src <[*.ls test/*.ls !browser.ls !Gulpfile.ls]> base: \.
  .pipe gulp-sourcemaps.init!
  .pipe gulp-livescript!
  .pipe gulp-sourcemaps.write \.
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

gulp.task \default, [\build]
