// Karma configuration
// http://karma-runner.github.io/0.10/config/configuration-file.html

module.exports = function(config) {
  config.set({
    // base path, that will be used to resolve files and exclude
    basePath: '',

    // testing framework to use (jasmine/mocha/qunit/...)
    frameworks: ['jasmine'],

    // list of files / patterns to load in the browser
    files: [
      // 'app/bower_components/jquery/dist/jquery.js',
      'app/bower_components/angular/angular.js',
      'app/bower_components/angular-mocks/angular-mocks.js',
      'app/bower_components/angular-resource/angular-resource.js',
      'app/bower_components/angular-cookies/angular-cookies.js',
      'app/bower_components/angular-sanitize/angular-sanitize.js',
      'app/bower_components/angular-route/angular-route.js',
      'app/scripts/**/*.js',
      'app/scripts/*.coffee',
      'test/spec/**/*.js',
      'test/client/spec/directives/recipient.coffee',
      '.tmp/**/*.js',
      'app/views/**/*.html'
    ],

    // list of files / patterns to exclude
    exclude: [],

    // web server port
    port: 8080,

    // level of logging
    // possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
    logLevel: config.LOG_INFO,


    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: false,


    // Start these browsers, currently available:
    // - Chrome
    // - ChromeCanary
    // - Firefox
    // - Opera
    // - Safari (only Mac)
    // - PhantomJS
    // - IE (only Windows)
    browsers: ['PhantomJS'],

    preprocessors : {
      'app/views/*.html': ['ng-html2js'],
      'app/views/**/*.html': ['ng-html2js'],
      '**/*.coffee': ['coffee']
    },

    ngHtml2JsPreprocessor : {
      moduleName: 'xoceanApp',

      // Function that transforms the path to look exactly like 
      // you have it in templateUrl in your Angular code
      //
      // Mine looks like this
      cacheIdFromPath: function(filepath) {
        return filepath.match(/views\/.*/)[0]
      }
    },

    coffeePreprocessor: {
      // options passed to the coffee compiler
      options: {
        bare: true,
        sourceMap: false
      },
      // transforming the filenames
      transformPath: function(path) {
        return path.replace(/\.coffee$/, '.js');
      }
    },
    // Continuous Integration mode
    // if true, it capture browsers, run tests and exit
    singleRun: false
  });
};
