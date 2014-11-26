window.typeAhead.component = flight.component ->
	@after 'initialize', ->
		@on document, 'typeahead:autocompleted', @resetTypeAhead
		@on document, 'typeahead:closed', @resetTypeAhead
		@on @$node, 'keypress', @checkForEnteredWord
		if @$node.attr('id') == 'emotions'
			@on document, 'emotions:indexFetched', @initializeTypeAhead
		if @$node.attr('id') == 'categories'
			@on document, 'categories:indexFetched', @initializeTypeAhead

	@initializeTypeAhead = (e, data) ->
		objType = @$node.attr('id')
		@dataList = data[objType]

		@$node.typeahead({
			hint: true
		},	
		{
			name: objType,
			displayKey: 'name',
			source: substringMatcher(@dataList, 'name')
		})

	@resetTypeAhead = (e) ->
		$('.typeahead').typeahead('close');
		$('.typeahead').typeahead('val', '');

	@checkForEnteredWord = (e) ->
		console.log e.charCode
		if e.charCode == 0 or e.charCode == 32
			names = @dataList.map (data) -> data.name.toLowerCase()
			enteredName = $.trim @$node.typeahead('val').toLowerCase()
			console.log enteredName
			i = names.indexOf enteredName
			if i > -1
				matchedObj = @dataList[i];
				data = $.extend {dataName: @$node.attr('id')}, matchedObj
				@trigger document, 'typeahead:autocompleted', data
				@$node.typeahead('val', '')
			else
				@trigger document, 'typeahead:noMatch'