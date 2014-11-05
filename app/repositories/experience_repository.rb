class ExperienceRepository < BaseRepository
	def search(search_terms={}, order_by='created_at', limit=nil)
		search_terms = symbolize_attributes search_terms
		query = Experience.all

		query = query.where(user_id: search_terms[:user_id]) if search_terms[:user_id]
		query = query.where(price: search_terms[:price]) if search_terms[:price]
		
		search_terms[:keywords].each do |keyword|
			start_of_word_term = "% #{keyword}%"
			start_of_word_in_parentheses_term = "%(#{keyword}%"
			start_of_title_term = "#{keyword}%"
			search  = "title LIKE #{start_of_word_term} OR description LIKE #{start_of_word_term} OR" +
				"title LIKE #{start_of_title_term} OR description LIKE #{start_of_title_term} OR" +
				"title LIKE #{start_of_word_in_parentheses_term} OR description LIKE #{start_of_word_in_parentheses_term}"
			query = query.where{
				(title =~ start_of_word_term) | (description =~ start_of_word_term) |
				(title =~ start_of_word_in_parentheses_term) | (description =~ start_of_word_in_parentheses_term) |
				(title =~ start_of_title_term) | (description =~ start_of_title_term) 
			}
		end if search_terms[:keywords]

		# must match all emotions
		# search_terms[:emotions].each do |emotion_name|
		# 	query = query.joins(:emotions).where{emotions.name =~ emotion_name}
		# end if search_terms[:emotions]

		# must only match one of the emotions
		if search_terms[:emotions]
			search_terms[:emotions].compact.each &:downcase!
			query = query.joins(:emotions).where{emotions.name.in(search_terms[:emotions])} 
		end

		if search_terms[:categories]
			search_terms[:categories].compact.each &:downcase!
			query = query.joins(:categories).where{categories.name.in(search_terms[:categories])} 
		end

		query.uniq!
	end

	# returns hash with unique sort_by attribute as key, matched models (sub-sorted by rating) as value
	# eg: {'sort_by' => 'price', 0 => [experience_1, experience_2], 1 => [experience_3]}
	# def sort(models, sort_by='created_at_date')
	# 	sorted_group_hash = { 'sort_by' => sort_by }
	# 	models.each do |model|
	# 		group = model[sort_by]
	# 		(sorted_group_hash[group] ||= []) << model
	# 	end
	# 	# subsort each group
	# 	sorted_group_hash.each { |group, models| models.sort_by! &:rating }
	# end

	protected

	def klass
		Experience
	end
end