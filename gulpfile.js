var gulp = require('gulp');
var gutil = require('gulp-util');

// Setup a paths object to easily access paths
var paths = {
  coffee: ['app/coffee/**/*.coffee'],
  sass: ['app/sass/*.scss'],
  jade: ['app/jade/**/*.jade'],
  jade_partials: ['app/partials/**/*.jade'],
  cjsx: ['app/coffee/components/**/*.cjsx'],
  image: ['app/images/**/*'],
  vendor: ['vendor/**/*']
};

// Compiles files, start the app and starts watching for changes
var watch = require('gulp-watch');
var spawn = require('child_process').spawn;
gulp.task('watch', ['serve'], function() {
  watch(paths.jade, function(){
    gulp.start('jade');
  });
  watch(paths.jade_partials, function(){
    gulp.start('jade');
  });
  watch(paths.coffee, function(){
    gulp.start('coffee');
  });
  watch(paths.sass, function(){
    gulp.start('sass');
  });
  watch(paths.cjsx, function(){
    gulp.start('cjsx');
  });
  watch(paths.image, function(){
    gulp.start('image');
  });
  watch(paths.vendor, function(){
    gulp.start('vendor');
  });
});

// Task that compiles all files
gulp.task('compile', ['jade', 'coffee', 'sass', 'cjsx', 'image', 'vendor']);

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

// Task to compile Sass files in app/sass to www/stylesheets
var sass = require('gulp-sass');
gulp.task('sass', function () {
    gulp.src(paths.sass)
        .pipe(sass())
        .pipe(gulp.dest('www/stylesheets'));
});

// Task to compile coffee+jsx files to JS
var cjsx = require('gulp-cjsx');
gulp.task('cjsx', function() {
  gulp.src(paths.cjsx)
    .pipe(cjsx({bare: true}).on('error', gutil.log))
    .pipe(sourcemaps.write('maps'))
    .pipe(gulp.dest('www/javascripts/components'));
});

// Task to compress images and move them to destination
var image = require('gulp-image');
gulp.task('image', function() {
  gulp.src(paths.image)
    .pipe(image())
    .pipe(gulp.dest('www/images'));
});

// Task to compile vendor assets to www/vendor
var image = require('gulp-image');
gulp.task('vendor', function() {
  gulp.src(paths.vendor)
    .pipe(gulp.dest('www/vendor'));
});

// Default task compiles, starts ionic server and watches files
gulp.task('default', ['watch']);
