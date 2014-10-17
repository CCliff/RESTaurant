class Table < ActiveRecord::Base
	validates :number, presence: true
	validates :number_guests, numericality: {greater_than: 0}, presence: true

	has_many(:orders)
	has_many(:food_items, :through => :orders)

	scope :paid_true, -> { where(paid: true) }
	scope :paid_false, -> { where(paid: false) }

	def to_s
		puts self.number
	end
end