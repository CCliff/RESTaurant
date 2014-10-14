require 'bundler'
Bundler.require(:default)
require './connection'

ROOT_PATH = Dir.pwd
Dir[ROOT_PATH+"/models/*.rb"].each{ |file| require file }

get '/' do 
	erb :index
end

get '/foods' do
	@foods = FoodItem.all

	erb :'food/foods'
end
