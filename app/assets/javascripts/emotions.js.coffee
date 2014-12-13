class @emotionsService
	@getEmotions = ->
	# TODO: REDIS CACHE EMOTIONS
		$.ajax('/emotions').done (data) ->
			@emotions = data.emotions
			$(document).trigger 'emotions:indexFetched', {'emotions': @emotions}
			@emotions

# $ ->
# 	window.emotionsService.getEmotions()
