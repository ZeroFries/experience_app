class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password
      t.string :password_confirmation
      t.boolean :account_confirmed

      t.timestamps
    end
  end
end
