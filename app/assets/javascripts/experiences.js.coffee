class @experiencesService
	@getExperiencesHtml = (filters) ->
	# TODO: REDIS CACHE CATEGORIES
		$.ajax("/experiences/?#{$.param(filters)}").done (data) ->
			$(document).trigger 'experiences:indexHTML', {html: data}
