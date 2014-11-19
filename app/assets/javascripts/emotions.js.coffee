class @emotionsService
	@getEmotions = ->
	# TODO: REDIS CACHE EMOTIONS
		$.ajax('/emotions').done (data) ->
			@emotions = data.emotions
			console.log @emotions
			$(document).trigger 'initalizeEmotionsTypeAhead', {emotions: @emotions}
			@emotions

$ ->
	window.emotionsService.getEmotions()
