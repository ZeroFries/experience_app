require 'test_helper'

class ExperienceTest < ActiveSupport::TestCase
  def setup
  	@experience = Experience.create!
  end

  test '#created_at_date' do
  	assert_equal Time.now.to_date, @experience.created_at_date
  end

  test '#rating' do
  	assert_equal 0, @experience.rating

  	3.times {|i| @experience.votes.create(up: true, user_id: i)}
  	assert_equal 3, @experience.rating

  	@experience.votes.create(up: false, user_id: 99)
  	assert_equal 2, @experience.rating
  end
end
