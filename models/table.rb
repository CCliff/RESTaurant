class Table < ActiveRecord::Base
	has_many(:orders)
	has_many(:food_items, :through => :orders)

	def to_s
		puts self.number
	end
end