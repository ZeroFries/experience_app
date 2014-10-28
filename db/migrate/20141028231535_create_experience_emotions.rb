class CreateExperienceEmotions < ActiveRecord::Migration
  def change
    create_table :experience_emotions do |t|
      t.references :experience, index: true
      t.references :emotion, index: true

      t.timestamps
    end
  end
end
