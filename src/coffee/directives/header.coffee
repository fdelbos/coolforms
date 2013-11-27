## 
## header.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 26 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormHeader',[]).
  directive('coolformHeader', () ->
  
    return {
      restrict: 'E'
      scope:
        header: '='
      template: templates.header
    }
  )
 