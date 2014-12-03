module ExperiencesHelper
	ONE_VOTE = 3600 # seconds == 1 hour

	def sort_by_most_recently_popular(experiences)
		sorted = experiences.sort_by do |experience|
			(ONE_VOTE * experience.rating) + experience.created_at.to_i
		end.reverse
	end

	def trailing_description(description)
		if description
		  description.length > 60 ? "#{description[0..60]}..."  : description
		end
	end

	def price_to_description(price)
		['Free', 'Cheap', 'Affordable', 'Expensive'][price.to_i]
	end

	def price_to_dollar_sign(price)
		['_', '$', '$$', '$$$'][price.to_i]
	end
end
