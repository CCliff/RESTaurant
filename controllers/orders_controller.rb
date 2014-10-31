class OrdersController < ApplicationController

  get '/' do
    authenticate!
    @unpaid_orders = Table.paid_false.includes(:orders).flat_map { |table| table.orders }

    @table_array = @unpaid_orders.map { |order| order.table }.uniq

    erb :'/order/orders'
  end

  get '/history' do
    authenticate!
    @paid_orders = Table.paid_true.includes(:orders).flat_map { |table| table.orders }

    @table_array = @paid_orders.map { |order| order.table }.uniq

    erb :'/order/order_history'
  end

  post '/' do
    authenticate!
    @food_items = params['food_item'] || []
    if @food_items.any?
      @food_items.each do |food_id|
        Order.create(table_id: params['table']['number'], food_item_id: food_id )
      end
    end
    redirect "/tables/#{params['table']['number']}"
  end

  patch '/:id' do
    authenticate!
    @order = Order.find(params[:id])
    no_charge = FoodItem.where(name: 'NO CHARGE')
    @order.update('food_item_id' => no_charge[0].id)

    redirect "/orders"
  end

  delete '/:id' do
    authenticate!
    @order = Order.find(params[:id])
    @order.destroy

    redirect "/orders"
  end

end