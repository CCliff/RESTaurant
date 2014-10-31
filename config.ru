require 'bundler'
Bundler.require

require './connection'


ROOT_PATH = Dir.pwd
Dir[ROOT_PATH+"/models/*.rb"].each do |file|
  require file
	puts "requiring #{file}"
end
Dir[ROOT_PATH+"/helpers/*.rb"].each do |file|
  require file
	puts "requiring #{file}"
end

require './controllers/application_controller'
require './controllers/users_controller'
require './controllers/food_items_controller'
require './controllers/orders_controller'
require './controllers/tables_controller'

map('/tables'){ run TablesController }
map('/orders'){ run OrdersController }
map('/food_items'){ run FoodItemsController}
map('/users'){ run UsersController}
map('/'){ run ApplicationController }