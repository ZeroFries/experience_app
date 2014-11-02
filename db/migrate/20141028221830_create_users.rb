class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password
      t.string :password_confirmation
      t.string :password_digest
      t.boolean :account_confirmed

      t.timestamps
    end

    add_index :users, :email
    add_index :users, :username
  end

end
