class CreateTablesTable < ActiveRecord::Migration
  def change
  	create_table :tables do |t|
  		t.integer :number
  		t.integer :number_guests
  	end
  end
end
