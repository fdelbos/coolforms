## 
## Gruntfile.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  4 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

fs = require('fs-extra')
path = require('path')
glob = require("glob")
jade = require('jade')
htmlmin = require("html-minifier")
marked = require("marked")
marked.setOptions({'sanitize':false})

module.exports = (grunt) ->

  coffee_sources = [
    "src/coffee/init.coffee",
    "src/coffee/directives/*.coffee",
    "src/coffee/validators/*.coffee",
    "src/coffee/services/*.coffee"]
  html_sources =  "src/html/*.html"
  templates_cache = "src/coffee/templates_cache.coffee"
  sources = coffee_sources.concat [templates_cache]

  config =
    pkg: grunt.file.readJSON('package.json')
                        
    uglify:
      options:
        banner: '/*\n * <%= pkg.name %> v<%= pkg.version %>\n * Copyright (c) 2013 Frederic Delbos | https://raw.github.com/fdelbos/coolforms/master/LICENSE.txt\n */\n'
        mangle: false
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
    'Generate a coffeescript files containing the html templates.', ->  
      tmpl = glob.sync(html_sources).map (f) ->
        minopt =
          removeComments: true
          collapseWhitespace: true
        content = htmlmin.minify("#{fs.readFileSync(f)}", minopt)
        "  $templateCache.put(\"coolForm.#{path.basename(f, '.html')}\", \"\"\"#{content}\"\"\")\n"
      content = "angular.module('CoolFormDirectives').run ($templateCache) ->\n" + tmpl.join('\n')
      fs.writeFileSync(templates_cache, content)
      grunt.log.writeln("File #{templates_cache} created.")
  )

  grunt.registerTask(
    'doc', 'Generate documentation', ->
      fs.mkdir('doc')
      fs.copySync('site/static', 'doc/static')
      fs.copySync('coolforms.js', 'doc/static/coolforms.js')
      tmpl = jade.compile(fs.readFileSync('site/template.jade'), {'pretty':true})
      mds = glob.sync('site/*.md')
      mds.map (f) ->
        data =
          content: marked(fs.readFileSync(f, 'utf8'))
          name: path.basename(f, '.md')
        fs.writeFileSync("doc/#{data.name}.html", tmpl(data))
  )


  grunt.registerTask('all', [
    'templates',
    'coffee',
    'uglify'])

  grunt.registerTask('default', ['all'])
  grunt.registerTask('test', ['karma'])
  grunt.registerTask('server', ['all', 'connect', 'watch'])
  grunt.registerTask('dev', ['all', 'connect', 'watch'])
