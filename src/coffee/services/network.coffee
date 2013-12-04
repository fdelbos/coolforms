## 
## definition.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 28 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormServices').
  factory('networkService', ($q) ->
    return ->

      getJSON = (url) ->
        deferred = $q.defer()
        $.getJSON(url, (data) ->
          deferred.resolve(data))
        return deferred.promise

      postForm = (url, data, onSuccess, onError) ->
        cfg =
          type: "POST"
          url: url
          data: data
          success: onSuccess
          error: onError
        $.ajax(cfg)

      net =
        getJSON: getJSON

      return net
  )
