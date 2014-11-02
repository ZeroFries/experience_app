class CreateEmotions < ActiveRecord::Migration
  def change
    create_table :emotions do |t|
      t.string :name

      t.timestamps
    end

    add_index :emotions, :name
  end
end
