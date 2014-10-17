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

	erb :'/food_item/foods'
end

get '/foods/new' do 
	erb :'/food_item/new'
end	

post '/foods' do
	food = FoodItem.create(params['food_item'])
	if food.valid?
		redirect '/foods'
	else
		@errors = food.errors.full_messages
		erb :'/food_item/new'
	end
end

get '/foods/:id' do
	@food_item = FoodItem.find(params[:id])
	@tables = @food_item.tables.uniq

	erb :'/food_item/show'
end	

get '/foods/:id/edit' do
	@food_item = FoodItem.find(params[:id])

	erb :'/food_item/edit'
end	

patch '/foods/:id' do
	@food_item = FoodItem.find(params[:id])
	@food_item.update(params['food_item'])

	redirect "/foods/#{params[:id]}"
end

delete '/foods/:id' do
	@food_item = FoodItem.find(params[:id])
	@food_item.destroy

	redirect '/foods'
end

get '/tables' do
	@tables = Table.all

	erb :'/table/tables'
end

get '/tables/new' do 
	erb :'/table/new'
end

post '/tables' do
	table = Table.create(params['table'])


	if table.valid?
		redirect '/tables'
	else
		@errors = table.errors.full_messages
		erb :'/table/new'
	end
end

get '/tables/:id' do
	@table = Table.find(params[:id])
	@food_items = FoodItem.all

	erb :'/table/show'
end

get '/tables/:id/edit' do
	@table = Table.find(params[:id])

	erb :'/table/edit'
end

patch '/tables/:id' do
	@table = Table.find(params[:id])
	@table.update(params['table'])

	redirect "/tables/#{@table.id}"
end

delete '/tables/:id' do 
	@table = Table.find(params[:id])
	@table.destroy

	redirect "/tables"
end

get '/orders' do 
	@unpaid_orders = Table.paid_false.includes(:orders).flat_map { |table| table.orders } 

	@table_array = @unpaid_orders.map { |order| order.table }.uniq

	erb :'/order/orders'
end

get '/orders/history' do 
	@paid_orders = Table.paid_true.includes(:orders).flat_map { |table| table.orders } 

	@table_array = @paid_orders.map { |order| order.table }.uniq

	erb :'/order/order_history'
end

post '/orders' do
	@food_items = params['food_item'] || []
	if @food_items.any?
		@food_items.each do |food_id|
			Order.create(table_id: params['table']['number'], food_item_id: food_id )
		end
	end
	redirect "/tables/#{params['table']['number']}"
end

patch '/orders/:id' do 
	@order = Order.find(params[:id])
	no_charge = FoodItem.where(name: 'NO CHARGE')
	@order.update('food_item_id' => no_charge[0].id)

	redirect "/orders"
end

get '/tables/:id/receipt' do
	@sum = 0
	subtotal = 0
	@food_items = Table.find(params[:id]).food_items
	File.open('public/receipt.txt', 'w')
	File.open('public/receipt.txt', 'a') do |f|
		@food_items.each do |food|
			f << food.name + "   $" + food.price.to_s + "\n"
			subtotal += food.price
		end
		f << "----------------------------- \n"
		f << "SubTotal:          $" + subtotal.to_s
	end

	erb :'/table/receipt'
end

patch '/tables/:id/checkout' do
	@table = Table.find(params[:id])

	@table.update('paid' => true)

	redirect "/orders"
end

delete '/orders/:id' do
	@order = Order.find(params[:id])
	@order.destroy

	redirect "/orders"
end

