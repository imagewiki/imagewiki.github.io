'use strict';

var conf    = require('./conf');
var path    = require('path');
var gulp    = require('gulp');
var ghPages = require('gulp-gh-pages');
var del     = require('del');
var rename  = require('gulp-rename');

// Gets CLI parameters
var minimist = require('minimist');
var knownOptions = {
  string: 'env',
  default: { env: process.env.NODE_ENV || 'development' }
};
var options = minimist(process.argv.slice(2), knownOptions);

// Sets the right constants file for deploy
gulp.task('constants', function(){
  var file = options.env + '.constants.coffee';

  if(options.env == 'production') {
    gulp.src('CNAME')
      .pipe(gulp.dest(path.join(conf.paths.dist, '/')));
  }

  gulp.src(path.join(conf.paths.const, file))
    .pipe(rename('index.constants.coffee'))
    .pipe(gulp.dest(path.join(conf.paths.src, '/app')));
});

// Clean dist folder
gulp.task('clean:dist', function () {
  return del([
    conf.paths.dist + '/**/*',
  ]);
});

// Deploys
gulp.task('deploy', ['clean:dist', 'build'], function() {
  var ghPagesOpts;

  // Tries to deploy to Local ENV
  if(options.env == 'local') {
    console.log("###############################################");
    console.log("#####                                     #####");
    console.log("#####  CAN'T DEPLOY TO LOCAL ENVIRONMENT  #####");
    console.log("#####                                     #####");
    console.log("###############################################");
    return false;
  }
  // Development Deploy
  else if(options.env == 'development') {
    ghPagesOpts = {
      branch: 'master'
    };
  }
  // Production Deploy
  else {
    ghPagesOpts = {
      remoteUrl: 'git@github.com:imagewiki/website.git',
      branch: 'test'
    };
  }

  return gulp.src(conf.paths.dist + '/**/*')
    .pipe(ghPages(ghPagesOpts));
});
