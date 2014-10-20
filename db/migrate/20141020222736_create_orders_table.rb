class CreateOrdersTable < ActiveRecord::Migration
  def change
  	create_table :orders do |t|
  		t.references :food_item
  		t.references :table
  		t.timestamps
  	end
  end
end
