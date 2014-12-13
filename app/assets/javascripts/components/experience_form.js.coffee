stepInputHTML = () ->
	stepCount = $('.experience-step').length

	"<div class=\"experience-step\">" +
	"<input type=\"hidden\" name=\"experience[steps_attributes][][ordinal]\" value=\"#{stepCount}\" class=\"ordinal\"></input>" + 
	"<div class=\"ui labeled input\">" +
	"<input data-validate=\"step\" placeholder=\"Step #{stepCount+1}\" type=\"text\" name=\"experience[steps_attributes][][description]\" class=\"description\">" +
	"<div class=\"ui corner red large label remove-step\" title=\"Remove Step\"><i class=\"remove icon\">" +
	"</i></div></input></div></div>"

labelHTML = (obj, objTypeSingle, objTypePlural) ->
	"<span class=\"category ui label #{obj.label_colour}\">#{obj.name}" +
	"<i class=\"remove-label remove icon\"></i>" +
	"<input type=\"hidden\" name=\"experience[experience_#{objTypePlural}_attributes][][#{objTypeSingle}_id]\" value=\"#{obj.id}\" class=\"#{objTypeSingle}_id\">" + 
	"</input></span>"

window.experienceForm.component = flight.component ->
	@attributes({
		addStepSelector: '#add-step',
		removeLabelSelector: '.remove-label',
		removeStepSelector: '.remove-step'
	})

	@after 'initialize', ->
		@initializeUI()
		@formEvents()

	@initializeUI = () ->
		$('#experience_price').dropdown()
		$('.ui.checkbox').checkbox()
		$('.ui.accordion').accordion()

	@formEvents = ->
		@on 'keypress', (e) ->
			e.preventDefault() if e.keyCode == 13
		@on document, 'removeStep', @removeStep
		@on 'click', {
			addStepSelector: @addStep,
			removeStepSelector: @removeStep,
			removeLabelSelector: @removeLabel
		}
		that = this
		$('#add-step').on 'keypress', (e) ->
			that.addStep() if e.keyCode == 13
		@on document, 'typeahead:autocompleted', @addLabel
			
	@addStep = () ->
		step = $(stepInputHTML())
		$('#step-container').append step

	@removeStep = (e, data) ->
		$step = $(e.target).parents('.experience-step')[0]
		$step.remove()
		for step, i in $('.experience-step')
			$(step).find('.description').attr('placeholder', "Step #{i+1}")
			$(step).find('.ordinal').attr('value', i)

	@addLabel = (e, data, dataName) ->
		dataName = data.dataName if dataName == undefined
		nameToSingular = {
			'emotions': 'emotion',
			'categories': 'category'
		}
		if !@alreadyBeenAdded(data, nameToSingular[dataName])
			$labelContainer = $("##{dataName}-label-container")
			$labelContainer.append(labelHTML(data, nameToSingular[dataName], dataName))

	@alreadyBeenAdded = (obj, objType) ->
		labelVals = $.map $(".#{objType}_id"), (input) -> parseInt $(input).val()
		labelVals.indexOf(obj.id) > -1

	@removeLabel = (e, data) ->
		$(e.target).parents('.ui.label')[0].remove()


# ********* Form Validation *********

window.experienceForm.validate = (form) ->
	$.fn.form.settings.keyboardShortcuts = false
	$.fn.form.settings.rules.timeExpression = (s) ->
		# eg: 14-15 minutes; 10.5-12.5s; 8 days 
		return true if s == '' or s == null
		units = [
			's|second(s?)|sec(s?)',
			'm|minute(s?)|min(s?)',
			'h|hour(s?)',
			'd|day(s?)',
			'w|week(s?)',
			'month(s?)'
		].join("|")
		numberRange = "(\\d+(\\.\\d+)?(\\-\\d+(\\.\\d+)?)?\\s?)"
		matcher = new RegExp("#{numberRange}(#{units})\\s", "i")
		console.log matcher
		matcher.test "#{s} "

	$.fn.form.settings.rules.isImage = (s) ->
		formats = [
			'jpg', 'bmp', 'png', 'gif'
		].join("|")
		matcher = new RegExp(formats, "i")
		matcher.test s

	$(form).form({
	  time: {
	  	identifier: 'experience_time_required'
		  rules: [
		  	{
		  		type: 'timeExpression',
		  		prompt: 'Time required must be a number or range plus unit of time. Examples: 12-15 minutes; 1.5 hours'
		  	}
		  ]
		},
	  title: {
	    identifier: 'experience_title',
	    rules: [
	      {
	        type: 'empty',
	        prompt: 'Give your experience a title'
	      }
	    ]
	  },
	  description: {
	    identifier: 'experience_description',
	    rules: [
	      {
	        type: 'empty',
	        prompt: 'Give your experience a description'
	      }
	    ]
	  },
	  avatar: {
	    identifier: 'experience_avatar',
	    rules: [
	      {
	        type: 'empty',
	        prompt: 'Upload an image which reminds you of your experience'
	      },
	      {
	        type: 'isImage',
	        prompt: 'File must be a valid image (jpg, png, gif, or bmp)'
	      }
	    ]
	  },
	  step: {
	    identifier: 'step',
	    rules: [
	      {
	        type: 'empty',
	        prompt: 'A step was left blank'
	      }
	    ]
	  }
	},
	{
		inline: true
	});
