class @categoriesService
	@getCategories = ->
	# TODO: REDIS CACHE CATEGORIES
		$.ajax('/categories').done (data) ->
			@categories = data.categories
			$(document).trigger 'initalizeCategoriesTypeAhead', {'categories': @categories}
			@categories

$ ->
	window.categoriesService.getCategories()
