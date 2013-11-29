## 
## app.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 29 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('app', ['CoolForm', 'ngRoute', 'ui.ace'],
  ($routeProvider, $locationProvider) ->
    $locationProvider.html5Mode false
    $routeProvider
    .when('/', templateUrl: 'home.html')
    .when('/demo/simple', templateUrl: 'demo/simple.html')
    .when('/demo/wizard', templateUrl: 'demo/wizard.html')
)

angular.module('app')
  .directive('demo', ->

    l = (scope) ->
  
      scope.showCode = ->
        if scope.code? and scope.code.display is false
          scope.code =
            display: true
            title: 'Hide Code'
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