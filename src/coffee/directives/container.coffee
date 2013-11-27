## 
## container.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 23 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormContainer', ['CoolFormLine', 'CoolFormHeader']).
  directive('coolformContainer', () ->

    return {
      restrict: 'E'
      scope:
        definition: '='
      template: templates.container
    }
  )