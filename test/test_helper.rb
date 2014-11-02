ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  def current_user
  	@current_user ||= User.create! email: 'fake@fake.com', username: 'testUser', password: 'password', password_confirmation: 'password'
  end
end
