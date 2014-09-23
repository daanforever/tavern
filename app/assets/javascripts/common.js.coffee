
ready = ->
  $( ".btn-rotate" ).on( "click", ( e ) ->

    btn          = $( this )
    icon         = $( this ).find( ".glyphicon" )
    
    window.animateClass = "icon-refresh-animate";
    window.activeClass  = "btn-info"

    btn.addClass(  activeClass )
    icon.addClass( animateClass )

#    window.setTimeout( ->
#      btn.removeClass(  activeClass )
#      icon.removeClass( animateClass )
#    , 2000 )

#    e.preventDefault()

  )


$(document).ready(ready)
$(document).on('page:load', ready)