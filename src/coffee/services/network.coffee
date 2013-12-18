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

      getJSON = (url, error) ->
        deferred = $q.defer()
        $.getJSON(url, (data) ->
          deferred.resolve(data)).fail(error)
        return deferred.promise

      sendForm = (params) ->
        cfg =
          type: params.method
          url: params.action
          contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
          data: params.data
          success: params.success
          error: params.error
          headers: params.headers
        $.ajax(cfg)

      net =
        getJSON: getJSON
        sendForm: sendForm

      return net
  )
