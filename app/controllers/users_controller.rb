class UsersController < ApplicationController
  before_action :authenticate_user!, only: :home
  def show
    @user = User.find_by(username: params[:username])
    if @user
      render 'show'
    else
      render ''
    end
  end

  def home
    @user = current_user
  end
end