class UsersController < ApplicationController

  def index

  end

  def login
    binding.pry
    @user = User.koala(request.env['omniauth.auth']['credentials'])
  end

end
