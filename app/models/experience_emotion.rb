# attributes experience_id, emotion_id

class ExperienceEmotion < ActiveRecord::Base
  belongs_to :experience
  belongs_to :emotion
end
