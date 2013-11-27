## 
## email.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 24 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormEmail', []).
  directive('coolformEmail', () ->

    l = (scope) ->

    return {
      restrict: 'E'
      scope:
        field: '='
      template: templates.email
      link: l
    }
  )