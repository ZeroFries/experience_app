# attributes: username, email, password, password_confirmation

class User < ActiveRecord::Base
	has_secure_password

	has_many :experiences
	has_many :comments
	has_many :votes
end
