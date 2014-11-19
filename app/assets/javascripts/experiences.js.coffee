# $ ->
# 	initializeUI()
# 	formEvents()

# initializeUI = () ->
# 	$('.ui.selection.dropdown').dropdown()
# 	$('.ui.checkbox').checkbox()
# 	$('.ui.accordion').accordion()
# 	$('#emotions .typeahead').typeahead({
# 		hint: true,
# 	},	
# 	{
# 		name: 'emotions',
# 		displayKey: 'value',
# 		source: substringMatcher(getEmotions())
# 	});

# formEvents = () ->
# 	$('#add-step').on 'click', (e) ->
# 		e.preventDefault()
# 		addStepInput()

# addStepInput = () ->
# 	$('#step-container').append $(stepInputHTML())
# 	$('.remove-step').off 'click.removeStep'
# 	$('.remove-step').on 'click.removeStep', ->
# 		step = $(this).parents('.experience-step')[0]
# 		removeStep(step)

# stepInputHTML = () ->
# 	stepCount = $('.experience-step').length

# 	"<div class=\"experience-step\">" +
# 	"<input type=\"hidden\" name=\"experience[steps_attributes][][ordinal]\" value=\"#{stepCount}\" class=\"ordinal\"></input>" + 
# 	"<div class=\"ui labeled input\">" +
# 	"<input placeholder=\"Step #{stepCount+1}\" type=\"text\" name=\"experience[steps_attributes][][description]\" class=\"description\">" +
# 	"<div class=\"ui corner red large label remove-step\" title=\"Remove Step\"><i class=\"remove icon\">" +
# 	"</i></div></input></div></div>"
	

# removeStep = (step) ->
# 	for step, i in $('.experience-step')
# 		$(step).find('.description').attr('placeholder', "Step #{i+1}")
# 		$(step).find('.ordinal').attr('value', i)



# # app/assets/javascript/components/my-component.js.coffee

	
