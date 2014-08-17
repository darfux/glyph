root = exports ? this
@klass_pool = {}

root.injectClass = (name, klass)->
	@klass_pool[name] = klass
	root["getClass#{name}"] = ->
		klass

ready = ->
	cont = $('body').attr('cont')
	action = $('body').attr('action')
	f() if f = eval("root.#{cont}_#{action}_js")

$(document).ready(ready)
$(document).on('page:load', ready)