class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :up
      t.references :user, index: true
      t.references :experience, index: true

      t.timestamps
    end
  end
end
