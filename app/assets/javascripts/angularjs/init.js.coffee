
@tavern = angular.module('tavern', []).config([
  "$httpProvider", ($httpProvider) ->
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
])

$(document).on('ready page:load', ->
  angular.bootstrap('body', ['tavern'])
)


# bootstrapAngular = ->
#   $('[ng-app]').each ->
#     module = $(this).attr('ng-app')
#     angular.bootstrap(this, [module])

# $(document).on('ready page:load', bootstrapAngular)