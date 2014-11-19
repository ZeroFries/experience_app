class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :description
      t.references :experience, index: true
      t.integer :ordinal

      t.timestamps
    end
  end
end
