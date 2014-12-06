labelHTML = (obj, objType) ->
	"<span class=\"ui label #{obj.label_colour}\">#{obj.name}" +
	"<input type=\"hidden\" name=\"#{objType}_id\" value=\"#{obj.id}\" class=\"#{objType}_id\">" + 
	"</input></span>"

window.experienceSearch.component = flight.component ->
	@after 'initialize', ->
		$('.ui.selection.dropdown').dropdown()
		@on '.item', 'click', ->
			@trigger 'experiences:filter'
		@on document, 'typeahead:autocompleted', @addLabel
		@on '#keywords', 'keydown blur', (e) ->
			if (!!e.keyCode && e.keyCode == 13) || !e.keyCode
			 @trigger 'experiences:filter'

		@on 'experiences:filter', @get_filtered_experiences

	@addLabel = (e, data, dataName) ->
		dataName = data.dataName if dataName == undefined
		nameToSingular = {
			'emotions': 'emotion',
			'categories': 'category'
		}
		$label_container = $("##{dataName}-label-container")
		$label_container.append(labelHTML(data, nameToSingular[dataName]))
		@trigger 'experiences:filter'

	@get_filtered_experiences = ->
		filters = { filters: {
			keywords: @getKeywords(),
			emotions: @getTagIds('emotions'),
			categories: @getTagIds('categories')
		}}
		console.log @getPrice
		if @getPrice() >= 0
			filters.price = @getPrice()
		console.log filters
		window.history.pushState({"html":$('body').html(),"pageTitle": 'lol'},"", "/experiences/?#{$.param(filters)}")

	@getKeywords = -> $('#keywords').val().split " "
	@getPrice = -> parseInt $('#price').dropdown('get value')
	@getTagIds = (tagType) ->
		$.map($("##{tagType}-label-container input"), (input) ->
			parseInt $(input).val()
		)