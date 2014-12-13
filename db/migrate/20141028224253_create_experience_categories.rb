class CreateExperienceCategories < ActiveRecord::Migration
  def change
    create_table :experience_categories do |t|
      t.references :experience, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
