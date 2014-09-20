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

pre_scroll_handler = null
init_nav_point = ->
	if pre_scroll_handler
		$(document).unbind('scroll', pre_scroll_handler) 
	active_point = (p)->
		$('#nav-point').children('div').each ->
			$(this).removeClass('nav-active')
		p.addClass('nav-active')

	judge_active = ->
		$($('#nav-point').children('div').get().reverse()).each ->
			anchor = $(this).attr('href')
			if $(window).scrollTop() > $(anchor).offset().top-2
				active_point($(this))
				history.replaceState(null, null, anchor);
				return false
			
	auto_scrolling = null
	$('#nav-point').children('div').each ->
		$(this).click ->
			active_point($(this))
			anchor = $(this).attr('href')
			top = $(anchor).offset().top;
			auto_scrolling = true
			$('html, body').stop().animate({
				scrollTop: top
			}, 1500,'easeOutCirc', ->
				auto_scrolling = false
				history.replaceState(null, null, anchor);
			)
	judge_active()
	active_point($($('#nav-point').children('div')[0])) unless location.hash

	pre_scroll_handler = ->
		return true if auto_scrolling
		judge_active()
		return true

	$(document).scroll(pre_scroll_handler) 

init_character_panel = ->
	$('#character-panel').children('.character').each ->
		$(this).click ->
			id = $(this).attr('id').split('-')[2]
			cshow = $('#character-show')
			cshow.removeClass()
			cshow.addClass('character')
			cshow.addClass("character-#{id}")
			$('#character-meaning').html($("#character-key-#{id}").attr('name'))

handle_ep0_p0 = ->
	init_nav_point()
	init_character_panel()


handle_ep0_p1 = ->
	init_nav_point()
	init_game(0, 1)

handle_ep1_p0 = ->
	init_nav_point()
	init_game(1, 0)
	
handle_ep2_p0 = ->
	init_game(2, 0)

root.main_index_js = ->
	init_list()

root.main_episode_js = ->
	ep = $('episode').attr('num')
	paragraph = $('paragraph').attr('num')
	eval("handle_ep#{ep}_p#{paragraph}()")



