require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
	include ApplicationHelper
	def setup
		# @helper = Class.new.extends(ApplicationHelper)
	end

	test '#time_ago' do
		date_time = DateTime.now - 1.seconds
		assert_equal "1 second ago", time_ago(date_time)

		date_time = DateTime.now - 23.seconds
		assert_equal "23 seconds ago", time_ago(date_time)

		date_time = DateTime.now - 2.minutes
		assert_equal "2 minutes ago", time_ago(date_time)

		date_time = DateTime.now - 1.hour
		assert_equal "60 minutes ago", time_ago(date_time)

		date_time = DateTime.now - 2.hours
		assert_equal "2 hours ago", time_ago(date_time)

		date_time = DateTime.now - 1.day
		assert_equal "1 day ago", time_ago(date_time)

		date_time = DateTime.now - 25.day
		assert_equal "25 days ago", time_ago(date_time)

		date_time = DateTime.now - 2.years
		assert_equal "on #{Date.strptime(date_time.to_i.to_s, '%s')}", time_ago(date_time)
	end
end
