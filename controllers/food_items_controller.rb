class FoodItemsController < ApplicationController
  get '/' do
    authenticate!
    @foods = FoodItem.all

    erb :'/food_item/foods'
  end

  get '/new' do
    authenticate!
    @food_item = FoodItem.new
    erb :'/food_item/new'
  end

  post '/' do
    authenticate!
    @food_item = FoodItem.create(params['food_item'])
    if @food_item.valid?
      redirect '/food_items'
    else
      @errors = @food_item.errors.full_messages
      erb :'/food_item/new'
    end
  end

  get '/:id' do
    authenticate!
    @food_item = FoodItem.find(params[:id])
    @tables = @food_item.tables.uniq

    erb :'/food_item/show'
  end

  get '/:id/edit' do
    authenticate!
    @food_item = FoodItem.find(params[:id])

    erb :'/food_item/edit'
  end

  patch '/:id' do
    authenticate!
    @food_item = FoodItem.find(params[:id])
    @food_item.update(params['food_item'])

    redirect "/food_items/#{params[:id]}"
  end

  delete '/:id' do
    authenticate!
    @food_item = FoodItem.find(params[:id])
    @food_item.destroy

    redirect '/food_items'
  end
end