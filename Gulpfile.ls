require! {
  gulp
  \gulp-livescript
  \gulp-rename
  \gulp-mocha
}

gulp.task \build ->
  gulp.src <[*.ls !Gulpfile.ls]> base: \.
  .pipe gulp-livescript!
  .pipe gulp.dest \.

gulp.task \test [\build] ->
  gulp.src \test.ls {-read}
  .pipe gulp-mocha reporter: \spec

gulp.task \default, [\test]
