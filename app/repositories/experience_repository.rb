class ExperienceRepository < BaseRepository
	def search(search_terms={}, order_by='created_at', limit=nil)
		search_terms = symbolize_attributes search_terms
		query = Experience.includes([:experience_emotions, :emotions])
		query = query.includes([:experience_categories, :categories])
		query = query.includes :steps

		query = query.where{user_id == search_terms[:user_id]} if search_terms[:user_id]
		query = query.where{price <= search_terms[:price]} unless search_terms[:price].blank?
		
		search_terms[:keywords].each do |keyword|
			start_of_word_term = "% #{keyword}%"
			start_of_word_in_parentheses_term = "%(#{keyword}%"
			start_of_title_term = "#{keyword}%"
			query = query.where{
				(title =~ start_of_word_term) | (description =~ start_of_word_term) |
				(title =~ start_of_word_in_parentheses_term) | (description =~ start_of_word_in_parentheses_term) |
				(title =~ start_of_title_term) | (description =~ start_of_title_term) 
			}
		end unless search_terms[:keywords].blank?

		# must match all emotions
		# search_terms[:emotions].each do |emotion_name|
		# 	query = query.joins(:emotions).where{emotions.name =~ emotion_name}
		# end if search_terms[:emotions]

		# must only match one of the emotions
		if search_terms[:emotions]
			if /\d+/.match search_terms[:emotions].first.to_s
				query = query.joins(:emotions).where{emotions.id.in(search_terms[:emotions])}  
			else
				search_terms[:emotions].compact.each &:downcase!
				query = query.joins(:emotions).where{emotions.name.in(search_terms[:emotions])}
			end
		end

		if search_terms[:categories]
			if /\d+/.match search_terms[:categories].first.to_s
				query = query.joins(:categories).where{categories.id.in(search_terms[:categories])}
			else
				search_terms[:categories].compact.each &:downcase!
				query = query.joins(:categories).where{categories.name.in(search_terms[:categories])} 
			end
		end

		query.order order_by
		query.limit limit if limit
		query.distinct
	end

	def find(query)
		models, success = super query
		models.includes([:experience_emotions, :emotions]).includes([:experience_categories, :categories]).includes(:steps) if success

		return models, success
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