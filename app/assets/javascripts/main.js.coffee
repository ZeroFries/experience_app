# Define namespaces
window.experienceForm ||= {}
window.experienceList ||= {}
window.experienceSearch ||= {}
window.typeAhead ||= {}

# Misc Functions
window.updateURL = (path) ->
	window.history.pushState({"html":$('body').html(),"pageTitle": 'Experience'},"", path)

$ ->