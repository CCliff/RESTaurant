require 'sinatra/base'

class ApplicationController < Sinatra::Base

  enable :sessions
  enable :method_override

  helpers Sinatra::AuthenticationHelper
  helpers Sinatra::ButtonHelper
  helpers Sinatra::FormHelper
  helpers Sinatra::LinkHelper
  helpers ActiveSupport::Inflector

  set :views, File.expand_path('../../views', __FILE__)
  set :public_folder, File.expand_path('../../public', __FILE__)

  get '/console' do
    binding.pry
  end

  get '/' do
    @user = User.new
    erb :index
  end

  get '/register' do
    @user = User.new
    erb :"users/new"
  end

  post '/login' do
    redirect '/' unless user = User.find_by(username: params[:username])
    if user.password == params[:password]
      session[:current_user] = user.id
      redirect '/tables'
    else
      redirect '/'
    end
  end

  delete '/logout' do
    session[:current_user] = nil
    redirect '/'
  end

end