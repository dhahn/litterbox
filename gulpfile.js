// This file goes in root of your app

var gulp = require('gulp');
var eta = require('gulp-eta');
var config = {};

// Scaffold configuration
config.scaffold = {
  source: {
    root: 'app/_src'
  },
  assets: {
    root: 'public/assets',
    styles: 'css',
    symbols: '../../../fonts/symbols/'
  }
};

eta(gulp, config);