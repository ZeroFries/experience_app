json.categories do
	json.array! @categories do |category|
		json.partial! 'category', category: category
	end
end