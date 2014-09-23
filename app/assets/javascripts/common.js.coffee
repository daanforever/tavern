
window.waitNetClass = "disabled";
window.animateClass = "icon-refresh-animate";

ready = ->

  $( ".btn-rotate" ).on( "click", ( e ) ->

    $( this ).addClass( waitNetClass )
    $( this ).find( ".glyphicon" ).addClass( animateClass )
    
  )


$(document).ready(ready)
$(document).on('page:load', ready)