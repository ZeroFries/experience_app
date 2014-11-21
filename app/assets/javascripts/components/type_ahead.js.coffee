$ ->
	typeAhead = flight.component ->
		@after 'initialize', ->
			@on document, 'typeahead:autocompleted', @resetTypeAhead
			@on document, 'typeahead:closed', @resetTypeAhead
			@on document, 'keypress', @checkForEnteredWord
			if @$node.attr('id') == 'emotions'
				@on document, 'initalizeEmotionsTypeAhead', @initializeTypeAhead
			if @$node.attr('id') == 'categories'
				@on document, 'initalizeCategoriesTypeAhead', @initializeTypeAhead


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
			if e.keyCode == 13 or e.charCode == 32
				names = @dataList.map (data) -> data.name.toLowerCase()
				enteredName = $.trim @$node.typeahead('val').toLowerCase()
				i = names.indexOf enteredName
				if i > -1
					matchedObj = @dataList[i];
					data = $.extend {dataName: @$node.attr('id')}, matchedObj
					@trigger document, 'typeahead:autocompleted', data
				else
					@trigger document, 'typeahead:noMatch'

	typeAhead.attachTo '#emotions.typeahead'
	typeAhead.attachTo '#categories.typeahead'