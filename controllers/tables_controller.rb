class TablesController < ApplicationController
  get '/' do
    authenticate!
    @tables = Table.all

    erb :'/table/tables'
  end

  get '/new' do
    authenticate!
    @table = Table.new
    erb :'/table/new'
  end

  post '/' do
    authenticate!
    @table = Table.create(params['table'])

    if @table.valid?
      redirect '/tables'
    else
      @errors = @table.errors.full_messages
      erb :'/table/new'
    end
  end

  get '/:id' do
    authenticate!
    @table = Table.find(params[:id])
    @food_items = FoodItem.all

    erb :'/table/show'
  end

  get '/:id/edit' do
    authenticate!
    @table = Table.find(params[:id])

    erb :'/table/edit'
  end

  patch '/:id' do
    authenticate!
    @table = Table.find(params[:id])
    @table.update(params['table'])

    redirect "/tables/#{@table.id}"
  end

  delete '/:id' do
    authenticate!
    @table = Table.find(params[:id])
    @table.destroy

    redirect "/tables"
  end
  patch '/:id/checkout' do
    authenticate!
    @table = Table.find(params[:id])

    @table.update('paid' => true)

    redirect "/tables/#{@table.id}/receipt"
  end

  get '/:id/receipt' do
    authenticate!
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

end