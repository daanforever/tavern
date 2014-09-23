# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

stopRefresh = ->

  $( ".btn-rotate" ).on( "ajax:success", (e, data, status, xhr) ->
    $( this ).removeClass( waitNetClass )
    $( this ).find( ".glyphicon" ).removeClass( animateClass )
  )

  $( ".btn-toggle" ).on( "ajax:success", (e, data, status, xhr) ->
    $( this ).toggleClass( "btn-info" )
  )


$(document).ready(stopRefresh)
$(document).on('page:load', stopRefresh)
