class Table < ActiveRecord::Base
	has_many(:orders)
	has_many(:food_items, :through => :orders)

	scope :paid_true, -> { where(paid: true) }
	scope :paid_false, -> { where(paid: false) }

	def to_s
		puts self.number
	end
end