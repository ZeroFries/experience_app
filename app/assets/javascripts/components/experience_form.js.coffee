stepInputHTML = () ->
	stepCount = $('.experience-step').length

	"<div class=\"experience-step\">" +
	"<input type=\"hidden\" name=\"experience[steps_attributes][][ordinal]\" value=\"#{stepCount}\" class=\"ordinal\"></input>" + 
	"<div class=\"ui labeled input\">" +
	"<input data-validate=\"step\" placeholder=\"Step #{stepCount+1}\" type=\"text\" name=\"experience[steps_attributes][][description]\" class=\"description\">" +
	"<div class=\"ui corner red large label remove-step\" title=\"Remove Step\"><i class=\"remove icon\">" +
	"</i></div></input></div></div>"

labelHTML = (obj, objType) ->
	"<span class=\"category ui label #{obj.label_colour}\">#{obj.name}" +
	"<input type=\"hidden\" name=\"experience[experience_#{objType}s_attributes][][#{objType}_id]\" value=\"#{obj.id}\" class=\"#{objType}_id\">" + 
	"</input></span>"

experienceForm = flight.component ->
	@after 'initialize', ->
		@initializeUI()
		@formEvents()

	@initializeUI = () ->
		$('.ui.selection.dropdown').dropdown()
		$('.ui.checkbox').checkbox()
		$('.ui.accordion').accordion()

	@formEvents = ->
		@on 'keypress', (e) ->
			e.preventDefault() if e.keyCode == 13
		@on document, 'removeStep', @removeStep
		$('#add-step').on 'click', @addStep
		that = this
		$('#add-step').on 'keypress', (e) ->
			that.addStep() if e.keyCode == 13
		@on document, 'typeahead:autocompleted', @addLabel
			
	@addStep = () ->
		step = $(stepInputHTML())
		$('#step-container').append step
		step.find('.description').focus()
		stepRemover = step.find '.remove-step'
		removeStep.attachTo stepRemover

	@removeStep = (e, data) ->
		$step = $(data.stepRemover).parents('.experience-step')[0]
		$step.remove()
		for step, i in $('.experience-step')
			$(step).find('.description').attr('placeholder', "Step #{i+1}")
			$(step).find('.ordinal').attr('value', i)

	@addLabel = (e, data, dataName) ->
		dataName = data.dataName if dataName == undefined
		$label_container = $("##{dataName}-label-container")
		$label_container.append(labelHTML(data, dataName.slice(0, -1)))

removeStep = flight.component ->
	@after 'initialize', ->
		@on 'click', @triggerRemoveStep
		# TODO: add esc keypress event

	@triggerRemoveStep = ->
		@trigger document, 'removeStep', {stepRemover: @node}


# ********* Form Validation *********

validateForm = (form) ->
	$(form).form({
	  title: {
	    identifier  : 'experience_title',
	    rules: [
	      {
	        type   : 'empty',
	        prompt : 'Give your experience a title'
	      }
	    ]
	  },
	  description: {
	    identifier  : 'experience_description',
	    rules: [
	      {
	        type   : 'empty',
	        prompt : 'Give your experience a description'
	      }
	    ]
	  },
	  step: {
	    identifier  : 'step',
	    rules: [
	      {
	        type   : 'empty',
	        prompt : 'Blank step(s)'
	      }
	    ]
	  }
	})

$ ->
	experienceForm.attachTo '#experience-form'
	validateForm '#experience-form'

	