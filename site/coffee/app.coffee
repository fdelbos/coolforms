## 
## app.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 29 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('app', ['CoolForm', 'CoolFormServices', 'ngRoute'],
  ($routeProvider, $locationProvider) ->
    $locationProvider.html5Mode false
    $routeProvider
      .when('/', templateUrl: 'home.html')
      .when('/demo/simple', templateUrl: 'demo/simple.html')
      .when('/demo/wizard', templateUrl: 'demo/wizard.html')
)

angular.module('app')
  .directive('demo', (definitionService) ->

    l = (scope) ->

      # scope.aceLoaded = (editor) ->
      #   console.log "titi!!!"
      #   scope.editor = editor
      #   session = editor.getSession()
      #   renderer = editor.renderer
      #   session.setUndoManager(new ace.UndoManager())
      #   renderer.setShowGutter(true)
      #   renderer.setUseWrapMode(true)
      #   renderer.setTheme('twilight')
      #   session.setMode('json')

      scope.definition = definitionService(scope.url).then((def) ->
        scope.form = def
        scope.jsonString = JSON.stringify(def, null, 2)
      )
                      
      # scope.jsonString = "salut"
      # scope.aceOptions =
      #   useWrapMode: true
      #   showGutter: true
      #   theme:'twilight'
      #   mode: 'json'
      
      scope.showCode = ->
        if scope.code? and scope.code.display is false
          scope.code =
            display: true
            title: 'Hide Code'
          #scope.editor.resize()
        else
          scope.code =
            display: false
            title: 'Show Code'      
      scope.showCode()

    return {
      restrict: 'E'
      scope:
        url: '@'
        name: '@'
      templateUrl: 'demo.html'
      link: l
      replace: true
      transclude: true
    }

  )
