labelHTML = (obj, objType) ->
	"<span class=\"ui label #{obj.label_colour}\">#{obj.name}" +
	"<i class=\"remove-label remove icon\"></i>" +
	"<input type=\"hidden\" name=\"#{objType}_id\" value=\"#{obj.id}\" class=\"#{objType}_id\">" +
	"</input></span>"

window.experienceSearch.component = flight.component ->
	@attributes({
		removeLabelSelector: '.remove-label',
		dropDownItemSelector: '.item'
	})

	@after 'initialize', ->
		$('.ui.selection.dropdown').dropdown()
		@on 'click', {
			removeLabelSelector: ((e, data) -> @removeLabel(e, data)),
			dropDownItemSelector: (-> @trigger 'experiences:filter')
		}
		@on document, 'typeahead:autocompleted', @addLabel
		@on '#keywords', 'keydown blur', (e) ->
			if (!!e.keyCode && e.keyCode == 13) || !e.keyCode
				@trigger 'experiences:filter'

		@on 'experiences:filter', @getFilteredExperiences

	@addLabel = (e, data, dataName) ->
			dataName = data.dataName if dataName == undefined
			nameToSingular = {
				'emotions': 'emotion',
				'categories': 'category'
			}
			if !@alreadyBeenAdded(data, nameToSingular[dataName])
				$labelContainer = $("##{dataName}-label-container")
				$labelContainer.append(labelHTML(data, nameToSingular[dataName]))
				@trigger 'experiences:filter'

	@alreadyBeenAdded = (obj, objType) ->
		labelVals = $.map $(".#{objType}_id"), (input) -> parseInt $(input).val()
		labelVals.indexOf(obj.id) > -1


	@removeLabel = (e, data) ->
		$(e.target).parents('.ui.label')[0].remove()
		@trigger 'experiences:filter'

	@getFilteredExperiences = ->
		filters = { filters: {
			keywords: @getKeywords(),
			emotions: @getTagIds('emotions'),
			categories: @getTagIds('categories')
		}}
		if @getPrice() >= 0
			filters.filters.price = @getPrice()
		window.updateURL "/experiences/?#{$.param(filters)}"
		experiencesService.getExperiencesHtml(filters)

	@getKeywords = -> $('#keywords').val().split " "
	@getPrice = -> parseInt $('#price').dropdown('get value')
	@getTagIds = (tagType) ->
		$.map($("##{tagType}-label-container input"), (input) ->
			parseInt $(input).val()
		)