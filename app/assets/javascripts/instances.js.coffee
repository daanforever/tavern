# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# updateHosts = ->
#   # $( document ).on( 'change', '.instance_environment select', ->
#   #   url = '/environments/' + $( this ).val() + '/hosts'
#   #   console.log( url )
#   #   $.getJSON(url, (data) ->
#   #     options = []
#   #     $.each(data, (key, value) -> 
#   #       options.push('<option value="' + value.id + '">' + value.name + '</option>')
#   #     )
#   #     # console.log(  )
#   #     $( '.instance_host select' ).removeClass( 'disabled' ).removeProp( 'disabled' ).html( options )
#   #   )
#   #   # $.getJSON('/environments/1/hosts', function (data){ $.each(data, function(key, val){ console.log(val.id + ' := ' + val.name) } ) })
#   # ).on('ajax:success', '.btn-action[data-remote=true]', (e, data, status, xhr) ->
#   #   $( this ).parent().parent().html( xhr.responseText )
#   # )


# $(document).ready(updateHosts)
# $(document).on('page:load', updateHosts)

@tavern.controller('instancesController', ($scope, $interval, $http) ->
  $( document ).on('ajax:success', '.btn-action[data-remote=true]', (e, data, status, xhr) ->
    $scope.refresh()
  )

  $scope.refresh = ->
    $http.defaults.headers.common.Accept = 'application/json'
    $http.get(
      window.location
    ).success( (data, status, headers, config) ->
      $scope.instances = data
      for instance in $scope.instances
         
        if instance.state      == 'stopped'
          instance.action_instance_path = instance.run_instance_path
          instance.action_class         = 'glyphicon-play'
        else if instance.state == 'running'
          instance.action_instance_path = instance.stop_instance_path
          instance.action_class         = 'glyphicon-pause'
        else
          instance.action_instance_path = '#'
          instance.action_class         = 'glyphicon-refresh icon-refresh-animate'

    ).error( (data, status, headers, config) ->
      console.log("AJAX failed!")
    );

  $scope.startRefresher = ->
    $scope.stop = $interval( ->
      $scope.refresh()
    , 5000)
    console.log('refresher started')

  $scope.stopRefresher = ->
    if angular.isDefined($scope.stop)
      $interval.cancel($scope.stop)
      $scope.stop = undefined
      console.log('refresher stopped')
)

@tavern.controller('InstanceFormController', ($scope) ->
  $scope.delete = (name, $event) ->
    panel = angular.element($event.target).closest('.panel' + name)
    panel.remove()
    true

  $scope.addVolume = ($event) ->
    volume = angular.element('.panel.volume').last()
    copy1  = volume.clone(true)
    copy2  = volume.clone(true)
    parent = volume.parent()
    copy1.find('a.ng-hide').toggleClass('ng-hide')
    parent.append(copy1)
    parent.append(copy2)
    volume.remove()
    true

  $scope.addPort = ($event) ->
    port   = angular.element('.panel.port').last()
    copy1  = port.clone(true)
    copy2  = port.clone(true)
    parent = port.parent()
    copy1.find('a.ng-hide').toggleClass('ng-hide')
    parent.append(copy1)
    parent.append(copy2)
    port.remove()
    true
)

$(document).on('ready page:load page:restore', ->
  angular.element('[ng-controller="instancesController"]').each( ->
    $(this).scope().startRefresher()
  )
  angular.element('.panel.volume').last().find('a.close').toggleClass('ng-hide')
  angular.element('.panel.port').last().find('a.close').toggleClass('ng-hide')
)

$(document).on('page:before-change', ->
  angular.element('[ng-controller="instancesController"]').each( ->
    $(this).scope().stopRefresher()
  )
)
