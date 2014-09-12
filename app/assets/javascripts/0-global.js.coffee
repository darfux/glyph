Function::property = (prop, desc) ->
  Object.defineProperty @prototype, prop, desc


root.shuffle_array = (a) ->
    i = a.length
    while --i > 0
        j = ~~(Math.random() * (i + 1))
        t = a[j]
        a[j] = a[i]
        a[i] = t
    a

root.p = ()->
	if console
        console.log.apply(console, arguments)

ready = ->
	cont = $('body').attr('cont')
	action = $('body').attr('action')
	f() if f = root["#{cont}_#{action}_js"]

$(document).ready(ready)
$(document).on('page:load', ready)