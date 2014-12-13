class @categoriesService
	@getCategories = ->
	# TODO: REDIS CACHE CATEGORIES
		$.ajax('/categories').done (data) ->
			@categories = data.categories
			$(document).trigger 'categories:indexFetched', {'categories': @categories}
			@categories

# $ ->
# 	window.categoriesService.getCategories()
