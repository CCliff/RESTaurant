class AddPaidColumnToTablesTable < ActiveRecord::Migration
  def change
  	add_column(:tables, :paid, :boolean, default: false)
  end
end
