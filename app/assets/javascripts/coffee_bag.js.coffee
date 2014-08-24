klass_pool = {}
root.fetch = (namespace)->
	container = klass_pool
	spaces = namespace.split('.')
	for node in spaces
		container = container[node]
	container

root.bag = (namespace, klass)->
	container = klass_pool
	spaces = namespace.split('.')
	for node in spaces[0..-2]
		container = (container[node] ||= {})
	container[spaces[-1..]] = klass