## 
## directive.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec 11 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormServices').
  factory('directivesService', ->

    return ->

      directives =
        text: "coolform-text"

      add = (type, name) -> directives[type] = name
      get = (type) -> directives[type]

      return {
        get: get
        add: add
      }
  )
