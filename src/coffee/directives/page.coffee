## 
## page.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 29 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 


angular.module('CoolFormDirectives').
  directive('coolformPage', ($templateCache) ->
          
    return {
      restrict: 'E'
      scope:
        page: '='
      template: $templateCache.get('coolForm.page')
    }
  )
