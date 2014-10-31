class UsersController < ApplicationController
  post '/' do
    @user = User.new(params['user'])
    password = params['password']
    @user.password = password
    @user.save!

    redirect '/tables'
  end

end