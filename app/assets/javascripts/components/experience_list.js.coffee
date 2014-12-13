window.experienceList.component = flight.component ->
	@after 'initialize', ->
		@on document, 'experiences:indexHTML', @setHTML

	@setHTML = (e, html) ->
		html = html.html
		@$node.html $(html).filter("##{@$node.attr('id')}").html()