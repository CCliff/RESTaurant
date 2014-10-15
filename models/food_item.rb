class FoodItem < ActiveRecord::Base
	has_many(:orders)
	has_many(:tables, :through => :orders)

	def to_s
		puts self.name
	end
end