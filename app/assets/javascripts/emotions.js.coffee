class @emotionsService
	@getEmotions = ->
	# TODO: REDIS CACHE EMOTIONS
	$.ajax('/emotions').done (data) ->
		console.log data
