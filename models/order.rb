class Order < ActiveRecord::Base
	belongs_to(:food_item)
	belongs_to(:table)

	def to_s
		puts self.food_item.to_s + " ordered " + self.table.to_s
	end
end