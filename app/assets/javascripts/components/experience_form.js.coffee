stepInputHTML = () ->
	stepCount = $('.experience-step').length

	"<div class=\"experience-step\">" +
	"<input type=\"hidden\" name=\"experience[steps_attributes][][ordinal]\" value=\"#{stepCount}\" class=\"ordinal\"></input>" + 
	"<div class=\"ui labeled input\">" +
	"<input placeholder=\"Step #{stepCount+1}\" type=\"text\" name=\"experience[steps_attributes][][description]\" class=\"description\">" +
	"<div class=\"ui corner red large label remove-step\" title=\"Remove Step\"><i class=\"remove icon\">" +
	"</i></div></input></div></div>"
	


$ ->
	experienceForm = flight.component ->
		@after 'initialize', ->
			@initializeUI()
			@formEvents()

		@initializeUI = () ->
			$('.ui.selection.dropdown').dropdown()
			$('.ui.checkbox').checkbox()
			$('.ui.accordion').accordion()
			
			$('#emotions .typeahead').typeahead({
				hint: true,
			},	
			{
				name: 'emotions',
				displayKey: 'value',
				source: substringMatcher(window.emotionsService.getEmotions())
			})

		@formEvents = ->
			@on document, 'removeStep', @removeStep
			@on document, 'addStep', @addStep
				
		@addStep = () ->
			step = $(stepInputHTML())
			$('#step-container').append step
			stepRemover = step.find '.remove-step'
			removeStep.attachTo stepRemover

		@removeStep = (e, data) ->
			$step = $(data.stepRemover).parents('.experience-step')[0]
			$step.remove()
			for step, i in $('.experience-step')
				$(step).find('.description').attr('placeholder', "Step #{i+1}")
				$(step).find('.ordinal').attr('value', i)


	addStep = flight.component ->
		@after 'initialize', ->
			@on 'click', @triggerAddStep

		@triggerAddStep = (e) ->
			e.preventDefault()
			@trigger document, 'addStep'

	removeStep = flight.component ->
		@after 'initialize', ->
			@on 'click', @triggerRemoveStep

		@triggerRemoveStep = ->
			@trigger document, 'removeStep', {stepRemover: @node}


	experienceForm.attachTo '#experience-form'
	addStep.attachTo '#add-step'