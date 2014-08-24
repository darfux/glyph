Function::property = (prop, desc) ->
  Object.defineProperty @prototype, prop, desc

root.p = ()->
	if console
        console.log.apply(console, arguments)

ready = ->
	cont = $('body').attr('cont')
	action = $('body').attr('action')
	f() if f = root["#{cont}_#{action}_js"]

$(document).ready(ready)
$(document).on('page:load', ready)