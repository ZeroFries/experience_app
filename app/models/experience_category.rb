# attributes experience_id, category_id

class ExperienceCategory < ActiveRecord::Base
  belongs_to :experience
  belongs_to :category
end
