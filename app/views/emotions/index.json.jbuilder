json.emotions do
	json.array! @emotions do |emotion|
		json.partial! 'emotion', emotion: emotion
	end
end