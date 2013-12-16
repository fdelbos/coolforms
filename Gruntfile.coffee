## 
## Gruntfile.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  4 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

fs = require('fs')
path = require('path')
glob = require("glob")
jade = require('jade')
marked = require("marked")

module.exports = (grunt) ->

  coffee_sources = [
    "src/coffee/init.coffee",
    "src/coffee/directives/*.coffee",
    "src/coffee/validators/*.coffee",
    "src/coffee/services/*.coffee"]
  html_sources =  "src/html/*.html"
  templates_source = "src/coffee/templates.coffee"
  sources = coffee_sources.concat [templates_source]

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
    'Generate a coffeescript files containing the html templates.', ->
      tmpl = glob.sync(html_sources).map (f) -> "  #{path.basename(f, '.html')}: \"\"\"#{fs.readFileSync(f)}\"\"\"\n"
      fs.writeFileSync(templates_source, "templates =\n" + tmpl.join('\n'))
      grunt.log.writeln("File #{templates_source} created.")
  )

  grunt.registerTask(
    'doc', 'Generate documentation', ->
      fs.mkdir('doc')
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
