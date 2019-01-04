class UsersController < ApplicationController 

  def index
    @users = User.where(role: 'customer')
  end

  def show
    @user = User.find(params[:id])
    @accounts = @user.accounts
  end

end
