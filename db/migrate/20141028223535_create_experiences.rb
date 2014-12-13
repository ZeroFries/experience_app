class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.references :user, index: true
      t.string :title
      t.text :description
      t.integer :price
      t.integer :time_spent_in_minutes
      t.boolean :location_dependent

      t.timestamps
    end
  end
end
