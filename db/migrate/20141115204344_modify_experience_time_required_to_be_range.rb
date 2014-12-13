class ModifyExperienceTimeRequiredToBeRange < ActiveRecord::Migration
  def change
  	remove_column :experiences, :time_spent_in_minutes
  	add_column :experiences, :time_required, :string
  end
end
