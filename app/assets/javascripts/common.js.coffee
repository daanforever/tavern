
window.waitNetClass         = "disabled"
window.animateClass         = "icon-refresh-animate"
window.animateReverseClass  = "icon-refresh-reverse-animate"
window.toggleClass          = "btn-default btn-warning"
window.errorClass           = "btn-danger"
window.errorClassTimeout    = 3000

animateStart = (item) ->
  item.addClass( waitNetClass )
  item.find( ".glyphicon" ).addClass( animateClass )

animateStop  = (item) ->
  item.removeClass( waitNetClass )
  item.find( ".glyphicon" ).removeClass( animateClass )

errorClassAdd = (item) ->
  window.original = item.prop( "className" )
  item.addClass( errorClass )

window.ready = ->

  $( document ).on( "click", ".btn-rotate", ( e ) ->

    $( this ).removeClass( errorClass )
    clearTimeout(errorClassTimer) unless typeof(errorClassTimer) == 'undefined'
    animateStart( $( this ) )

  ).on( "click", ".btn-back", ( e ) ->
    e.preventDefault()
    history.back()
  ).on( "ajax:success", ".btn-rotate", (e, data, status, xhr) ->

    animateStop( $( this ) )

  ).on( "ajax:error", ".btn-rotate", (e, data, status, xhr) ->

    btn = $( this )
    animateStop( btn )
    errorClassAdd( btn )
    window.errorClassTimer = window.setTimeout( ->
      btn.removeClass( errorClass )
      btn.addClass( window.original )
    , errorClassTimeout)

  ).on( "ajax:success", ".btn-toggle", (e, data, status, xhr) ->
    $( this ).toggleClass( toggleClass )
  )

$(document).ready(ready)
$(document).on('page:load', ready)