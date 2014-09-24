
window.waitNetClass = "disabled"
window.animateClass = "icon-refresh-animate"
window.toggleClass  = "btn-danger btn-success"

window.ready = ->

  $( document ).on( "click", ".btn-rotate", ( e ) ->

    $( this ).addClass( waitNetClass )
    $( this ).find( ".glyphicon" ).addClass( animateClass )
    
  ).on( "ajax:success", ".btn-rotate", (e, data, status, xhr) ->

    $( this ).removeClass( waitNetClass )
    $( this ).find( ".glyphicon" ).removeClass( animateClass )

  )

  $( document ).on( "ajax:success", ".btn-toggle", (e, data, status, xhr) ->
    $( this ).toggleClass( toggleClass )
  )

$(document).ready(ready)
$(document).on('page:load', ready)