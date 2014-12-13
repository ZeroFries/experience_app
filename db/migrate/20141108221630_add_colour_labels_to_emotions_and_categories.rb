class AddColourLabelsToEmotionsAndCategories < ActiveRecord::Migration
  def change
  	add_column :emotions, :label_colour, :string
  	add_column :categories, :label_colour, :string
  end
end
