module ExperiencesHelper
	ONE_VOTE = 3600 # seconds == 1 hour

	def sort_by_most_recently_popular(experiences)
		sorted = experiences.sort_by do |experience|
			(ONE_VOTE * experience.rating) + experience.created_at.to_i
		end.reverse
	end

	def trailing_description(description)
		description ? "#{description[0..30]}..." : ""
	end
end
