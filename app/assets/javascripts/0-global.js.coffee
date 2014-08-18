root = exports ? this

Function::property = (prop, desc) ->
  Object.defineProperty @prototype, prop, desc

@klass_pool = {}
root.injectClass = (name, klass)->
	@klass_pool[name] = klass
	root["getClass#{name}"] = ->
		klass
root.p = ()->
	if console
        console.log.apply(console, arguments)

root.require = (namespace)->
	@['test_method'] = ->
		p('hello!')

root.package = (namespace)->

ready = ->
	cont = $('body').attr('cont')
	action = $('body').attr('action')
	f() if f = eval("root.#{cont}_#{action}_js")

class Util
	@setXCenter = (displayObject, container)->
		if container != undefined
			displayObject.x = container.width/2 - displayObject.width/2
		else if displayObject.parent
			displayObject.x = displayObject.parent.width/2 - displayObject.width/2

root.Util = Util

$(document).ready(ready)
$(document).on('page:load', ready)