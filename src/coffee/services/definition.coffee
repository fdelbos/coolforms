## 
## definition.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 28 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormServices').
  factory('definitionService', ($q) ->
    return (url) ->
      deferred = $q.defer()
      $.getJSON(url, (data) ->
        deferred.resolve(data))
      return deferred.promise
  )
