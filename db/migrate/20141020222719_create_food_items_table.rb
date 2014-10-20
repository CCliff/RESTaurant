class CreateFoodItemsTable < ActiveRecord::Migration
  def change
  	create_table :food_items do |t|
  		t.string :name
  		t.integer :price
  	end
  end
end
