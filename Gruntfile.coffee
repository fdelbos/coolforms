## 
## Gruntfile.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  4 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

module.exports = (grunt) ->

  coffee_sources = [
    "src/coffee/init.coffee",
    "src/coffee/directives/*.coffee",
    "src/coffee/validators/*.coffee",
    "src/coffee/services/*.coffee"]
  html_sources =  "src/html/*.html"
  sources = coffee_sources.concat ["src/coffee/templates.coffee"]

  config =
    pkg: grunt.file.readJSON('package.json')
                        
    uglify:
      options:
        banner: '/*! <%= pkg.name %> <%= pkg.version %> */\n'
      build:
        src: '<%= pkg.name %>.js'
        dest: '<%= pkg.name %>.min.js'

    coffee:
      options:
        join: true
      compile:
        files:
          '<%= pkg.name %>.js': sources

    connect:
      server:
        options:
          port: 8000
          keepalive: false

    watch:
      coffee:
        files: coffee_sources
        tasks: ['coffee']
      html:
        files: html_sources
        tasks: ['templates', 'coffee']

    karma:
      unit:
        configFile: 'karma.conf.coffee'

  grunt.initConfig config
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-karma'

  grunt.registerTask(
    'templates',
    'Generate a coffeescript files containing the html templates.',
    ->
      dest = 'src/coffee/templates.coffee'
      tmpl = "templates =\n"
      fs = require('fs')
      path = require('path')
      glob = require("glob")
      for f in glob.sync(html_sources)
        name = (path.basename(f, '.html'))
        content = fs.readFileSync(f)
        tmpl += "  #{name}: \"\"\"#{content}\"\"\"\n"
      fs.writeFileSync(dest, tmpl)
      grunt.log.writeln("File #{dest} created.")
    )

  grunt.registerTask('all', [
    'templates',
    'coffee',
    'uglify'])

  grunt.registerTask('default', ['all'])
  grunt.registerTask('server', ['all', 'connect', 'watch'])
  
