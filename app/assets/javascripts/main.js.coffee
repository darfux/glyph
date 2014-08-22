# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#-import glyph.game.lib.Util
init_list = ->
	$('.episode-select').each ->
		that = $(this)
		that.click ->
			ep_url = that.attr('href')
			window.open(ep_url)

root.main_index_js = ->
	init_list()

root.main_episode_js = ->
	ep = $('episode').attr('num')
	init_game(ep)
	# Util.setXCenter(null)



