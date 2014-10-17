class FoodItem < ActiveRecord::Base
	validates :name, uniqueness: true, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0}, presence: true
	
	has_many(:orders)
	has_many(:tables, :through => :orders)

	def to_s
		puts self.name
	end
end