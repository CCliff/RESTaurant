# require 'bundler'
# Bundler.require(:default)
# require './connection'

# helpers ActiveSupport::Inflector

# ROOT_PATH = Dir.pwd
# Dir[ROOT_PATH+"/models/*.rb"].each{ |file| require file }
# Dir[ROOT_PATH+"/helpers/*.rb"].each{ |file| require file }

# enable :sessions

# get '/console' do
# 	binding.pry
# end

# get '/' do
#   @user = User.new

# 	erb :index
# end

# post '/users' do
# 	@user = User.new(params['user'])
# 	password = params['password']
# 	@user.password = password
# 	@user.save!

# 	redirect '/tables'
# end

# get '/register' do
# 	@user = User.new
# 	erb :"users/new"
# end

# post '/login' do
# 	redirect '/' unless user = User.find_by(username: params[:username])
# 	if user.password == params[:password]
# 		session[:current_user] = user.id
# 		redirect '/tables'
# 	else
# 		redirect '/'
# 	end
# end

# delete '/logout' do
# 	session[:current_user] = nil
# 	redirect '/'
# end

# get '/food_items' do
# 	authenticate!
# 	@foods = FoodItem.all

# 	erb :'/food_item/foods'
# end

# get '/food_items/new' do
# 	authenticate!
# 	@food_item = FoodItem.new
# 	erb :'/food_item/new'
# end

# post '/food_items' do
# 	authenticate!
# 	@food_item = FoodItem.create(params['food_item'])
# 	if @food_item.valid?
# 		redirect '/food_items'
# 	else
# 		@errors = @food_item.errors.full_messages
# 		erb :'/food_item/new'
# 	end
# end

# get '/food_items/:id' do
# 	authenticate!
# 	@food_item = FoodItem.find(params[:id])
# 	@tables = @food_item.tables.uniq

# 	erb :'/food_item/show'
# end

# get '/food_items/:id/edit' do
# 	authenticate!
# 	@food_item = FoodItem.find(params[:id])

# 	erb :'/food_item/edit'
# end

# patch '/food_items/:id' do
# 	authenticate!
# 	@food_item = FoodItem.find(params[:id])
# 	@food_item.update(params['food_item'])

# 	redirect "/food_items/#{params[:id]}"
# end

# delete '/food_items/:id' do
# 	authenticate!
# 	@food_item = FoodItem.find(params[:id])
# 	@food_item.destroy

# 	redirect '/food_items'
# end

# get '/tables' do
# 	authenticate!
# 	@tables = Table.all

# 	erb :'/table/tables'
# end

# get '/tables/new' do
# 	authenticate!
# 	@table = Table.new
# 	erb :'/table/new'
# end

# post '/tables' do
# 	authenticate!
# 	@table = Table.create(params['table'])

# 	if @table.valid?
# 		redirect '/tables'
# 	else
# 		@errors = @table.errors.full_messages
# 		erb :'/table/new'
# 	end
# end

# get '/tables/:id' do
# 	authenticate!
# 	@table = Table.find(params[:id])
# 	@food_items = FoodItem.all

# 	erb :'/table/show'
# end

# get '/tables/:id/edit' do
# 	authenticate!
# 	@table = Table.find(params[:id])

# 	erb :'/table/edit'
# end

# patch '/tables/:id' do
# 	authenticate!
# 	@table = Table.find(params[:id])
# 	@table.update(params['table'])

# 	redirect "/tables/#{@table.id}"
# end

# delete '/tables/:id' do
# 	authenticate!
# 	@table = Table.find(params[:id])
# 	@table.destroy

# 	redirect "/tables"
# end

# get '/orders' do
# 	authenticate!
# 	@unpaid_orders = Table.paid_false.includes(:orders).flat_map { |table| table.orders }

# 	@table_array = @unpaid_orders.map { |order| order.table }.uniq

# 	erb :'/order/orders'
# end

# get '/orders/history' do
# 	authenticate!
# 	@paid_orders = Table.paid_true.includes(:orders).flat_map { |table| table.orders }

# 	@table_array = @paid_orders.map { |order| order.table }.uniq

# 	erb :'/order/order_history'
# end

# post '/orders' do
# 	authenticate!
# 	@food_items = params['food_item'] || []
# 	if @food_items.any?
# 		@food_items.each do |food_id|
# 			Order.create(table_id: params['table']['number'], food_item_id: food_id )
# 		end
# 	end
# 	redirect "/tables/#{params['table']['number']}"
# end

# patch '/orders/:id' do
# 	authenticate!
# 	@order = Order.find(params[:id])
# 	no_charge = FoodItem.where(name: 'NO CHARGE')
# 	@order.update('food_item_id' => no_charge[0].id)

# 	redirect "/orders"
# end





