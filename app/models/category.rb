# attributes: name

class Category < ActiveRecord::Base
	validates :name, presence: true
end
