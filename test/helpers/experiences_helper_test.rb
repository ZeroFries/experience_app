require 'test_helper'

class ExperiencesHelperTest < ActionView::TestCase
	include ExperiencesHelper

	def setup
	end

	test '#sort_by_most_recently_popular' do
		suppress_warnings { ExperiencesHelper::ONE_VOTE = 28800 } # 1 vote == 8 hours
		experience1 = Experience.create! created_at: Time.now
		experience2 = Experience.create! created_at: Time.now - 1.days
		experience3 = Experience.create! created_at: Time.now - 2.days
		# 2 days = -6 votes
		3.times { experience1.votes.create up: false }
		3.times { experience2.votes.create up: true }
		5.times { experience3.votes.create up: true }

		sorted_experiences = sort_by_most_recently_popular [experience1, experience2, experience3]

		assert_equal experience2, sorted_experiences.first
		assert_equal experience3, sorted_experiences.second
		assert_equal experience1, sorted_experiences.last 
	end
end
