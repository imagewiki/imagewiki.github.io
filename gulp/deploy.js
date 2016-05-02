'use strict';

var path    = require('path');
var gulp    = require('gulp');
var ghPages = require('gulp-gh-pages');
var conf    = require('./conf');


gulp.task('deploy:dev', ['build'], function() {
  return gulp.src(conf.paths.dist + '/**/*')
    .pipe(ghPages({
      branch: 'master'
    }));
});

gulp.task('deploy:prod', ['build'], function() {
  return gulp.src(conf.paths.dist + '/**/*')
    .pipe(ghPages({
      remoteUrl: 'git@github.com:imagewiki/website.git',
      branch: 'gh-pages'
    }));
});