experience.attributes.keys.each do |k|
	json.extract! experience, k.to_sym
end
json.extract! experience, :rating
json.extract! experience, :emotion_names
json.extract! experience, :category_names