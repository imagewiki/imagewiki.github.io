'use strict';

var path    = require('path');
var gulp    = require('gulp');
var ghPages = require('gulp-gh-pages');
var conf    = require('./conf');


gulp.task('deploy', ['build'], function() {
  return gulp.src(conf.paths.dist + '/**/*')
    .pipe(ghPages());
});