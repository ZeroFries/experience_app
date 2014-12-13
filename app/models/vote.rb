# attributes: up, user_id, experience_id

class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :experience

  def value
  	up ? 1 : -1
  end
end
