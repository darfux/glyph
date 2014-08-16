root = exports ? this

ready = ->
	cont = $('body').attr('cont')
	action = $('body').attr('action')
	f() if f = eval("root.#{cont}_#{action}_js")

$(document).ready(ready)
$(document).on('page:load', ready)