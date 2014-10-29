
@tavern = angular.module('tavern', [])

$(document).on('ready page:load', ->
  angular.bootstrap('body', ['tavern'])
)