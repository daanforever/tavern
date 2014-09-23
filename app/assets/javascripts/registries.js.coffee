# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

stopRefresh = ->

  $( ".btn-rotate" ).on( "ajax:success", (e, data, status, xhr) ->
    btn          = $( this )
    icon         = $( this ).find( ".glyphicon" )

    btn.removeClass(  activeClass )
    icon.removeClass( animateClass )
  )

  $( ".btn-toggle" ).on( "ajax:success", (e, data, status, xhr) ->
    btn          = $( this )
    icon         = $( this ).find( ".glyphicon" )

    btn.removeClass(  activeClass )
    icon.removeClass( animateClass )
  )


$(document).ready(stopRefresh)
$(document).on('page:load', stopRefresh)
