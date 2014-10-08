# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


updateHosts = ->
  $( document ).on( 'change', '.instance_environment select', ->
    environment = $( this ).val()
    console.log(  )
    # $.getJSON('/environments/1/hosts', function (data){ $.each(data, function(key, val){ console.log(val.id + ' := ' + val.name) } ) })
  )


$(document).ready(updateHosts)
$(document).on('page:load', updateHosts)
