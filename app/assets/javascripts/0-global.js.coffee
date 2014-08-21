#-nobag
Function::property = (prop, desc) ->
  Object.defineProperty @prototype, prop, desc

__klass_pool = {}

root.p = ()->
	if console
        console.log.apply(console, arguments)

root.fetch = (namespace)->
	container = __klass_pool
	spaces = namespace.split('.')
	p namespace, container
	for node in spaces
		container = container[node]
	container

root.bag = (namespace, klass)->
	container = __klass_pool
	spaces = namespace.split('.')
	for node in spaces[0..-2]
		container = (container[node] ||= {})
	container[spaces[-1..]] = klass
	p __klass_pool

ready = ->
	cont = $('body').attr('cont')
	action = $('body').attr('action')
	f() if f = root["#{cont}_#{action}_js"]

$(document).ready(ready)
$(document).on('page:load', ready)