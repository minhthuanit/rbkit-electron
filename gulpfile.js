var gulp = require('gulp');
var gutil = require('gulp-util');

// Setup a paths object to easily access paths
var paths = {
  coffee: ['app/coffee/**/*.coffee'],
  jade: ['app/jade/**/*.jade']
};

// Compiles files, start the app and starts watching for changes
var watch = require('gulp-watch');
var spawn = require('child_process').spawn;
gulp.task('watch', ['serve'], function() {
  watch(paths.jade, function(){
    gulp.start('jade');
  });
  watch(paths.coffee, function(){
    gulp.start('coffee');
  });
});

// Task that compiles all files
gulp.task('compile', ['jade', 'coffee']);

// Task to start electron app
gulp.task('serve', ['compile'], function(){
  spawn('Electron', ['.'], {stdio: 'inherit'});
});

// Task to convert jade templates in app/jade to HTML in www/
var jade = require('gulp-jade');
gulp.task('jade', function() {
  gulp.src(paths.jade)
    .pipe(jade({pretty: true}))
    .pipe(gulp.dest('www/'));
});

// Task to compile coffee files in app/coffee to www/javascripts
var coffee = require('gulp-coffee');
var sourcemaps = require('gulp-sourcemaps');
gulp.task('coffee', function() {
  gulp.src(paths.coffee)
    .pipe(sourcemaps.init())
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(sourcemaps.write('maps'))
    .pipe(gulp.dest('www/javascripts'));
});

// Default task compiles, starts ionic server and watches files
gulp.task('default', ['watch']);
