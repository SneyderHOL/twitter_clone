class UsersController < ApplicationController
  # before_action :authenticate_user!, only: :home
  def show
    @user = User.find_by(username: params[:username])
    if @user
      @user_tweets = @user.tweets.page(params[:page]).order('created_at DESC')
    else
      render inline: 'User not found'
    end
  end

  def home
    @user = User.find_by(username: params[:username])
    unless @user
      render inline: 'User not found'
    end
  end
end