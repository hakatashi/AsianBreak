require! {
  gulp
  \gulp-livescript
  \gulp-rename
}

gulp.task \build ->
  gulp.src <[*.ls tests/*.ls !Gulpfile.ls]> base: \.
  .pipe gulp-livescript!
  .pipe gulp.dest \.

gulp.task \default, [\build]
