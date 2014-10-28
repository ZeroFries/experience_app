# attributes: text, user_id, experience_id

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :experience
end
