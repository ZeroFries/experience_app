# attributes: title, description, price, time_spent_in_minutes, location_dependent, user_id

class Experience < ActiveRecord::Base
  belongs_to :user
  
  has_many :experience_emotions
  has_many :emotions, through: :experience_emotions
  has_many :votes
  has_many :comments
  has_many :experience_categories
  has_many :categories, through: :experience_categories
end
