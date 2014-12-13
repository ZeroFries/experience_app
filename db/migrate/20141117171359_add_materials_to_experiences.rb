class AddMaterialsToExperiences < ActiveRecord::Migration
  def change
  	add_column :experiences, :materials, :text
  end
end
