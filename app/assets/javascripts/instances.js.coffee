# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


updateHosts = ->
  $( document ).on( 'change', '.instance_environment select', ->
    url = '/environments/' + $( this ).val() + '/hosts'
    console.log( url )
    $.getJSON(url, (data) ->
      options = []
      $.each(data, (key, value) -> 
        options.push('<option value="' + value.id + '">' + value.name + '</option>')
      )
      # console.log(  )
      $( '.instance_host select' ).removeClass( 'disabled' ).removeProp( 'disabled' ).html( options )
    )
    # $.getJSON('/environments/1/hosts', function (data){ $.each(data, function(key, val){ console.log(val.id + ' := ' + val.name) } ) })
  ).on('ajax:success', '.btn-action[data-remote=true]', (e, data, status, xhr) ->
    $( ".table.instances" ).html( xhr.responseText )
  )


$(document).ready(updateHosts)
$(document).on('page:load', updateHosts)
