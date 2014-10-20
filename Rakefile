require 'bundler'
Bundler.require

require 'sinatra/activerecord/rake'
require_relative 'connection.rb'

namespace :db do
	desc "Create the restaurant_db"
	task :create_db do
		conn = PG::Connection.open()
		conn.exec ('CREATE DATABASE restaurant_db;')
		conn.close
	end
	desc "Drop restaurant_db"
	task :drop_db do
		conn = PG::Connection.open()
		conn.exec ('Drop DATABASE restaurant_db;')
		conn.close
	end

	desc "add junk data to the tables"
	task :junk_data do

		require_relative 'connection'
    require_relative 'models/food_item'
    require_relative 'models/table'
    require_relative 'models/order'

		FoodItem.create(name: "Chicken Parm", price: 10)
		FoodItem.create(name: "Burger", price: 8)
		FoodItem.create(name: "Chili", price: 7)
		FoodItem.create(name: "Sausage Sandwich", price: 11)
		FoodItem.create(name: "Pizza", price: 17)
		FoodItem.create(name: "Caesar Salad", price: 7)

		i = 1
		10.times do 
			Table.create(number: i, number_guests: rand(0..10))
			i+=1
		end

		tables = Table.all
		food = FoodItem.all
		tables.each do |table|
			table.number_guests.times do
				Order.create(food_item_id: food.sample.id, table_id: table.id)
			end
		end
	end
	desc "Delete the receipts"
	task :delete_receipts do
			`rm public/receipt.txt`
	end
end