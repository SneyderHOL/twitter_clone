class UsersController < ApplicationController
  # before_action :authenticate_user!, only: :home
  def show
    @user = User.find_by(username: params[:username])
    if @user
      @user_tweets = @user.tweets.page(params[:page]).order('created_at DESC')
    else
      render 'shared/not_found'
    end
  end

  def home
    @user = User.find_by(username: params[:username])
    unless @user
      render 'shared/not_found'
    end
  end

  def follow
    @user = current_user
  end

  def follow_to
    @user = current_user
    @followee = User.find_by(username: params[:followee])
    # byebug
    if @followee
      if @user.followees.include?(@followee)
        flash.now[:alert] = "You already follow #{ @followee.username }"
        render 'follow'
      else
        follow = Follow.create(follower: @user, followee: @followee)
        redirect_to user_tweets_path(@followee.username)
      end
    else
      flash.now[:alert] = "The user #{ params[:followee] } does not exists"
      render 'follow'
    end
  end

  def followees
    @user = User.find_by(username: params[:username])
    unless @user
      render 'shared/not_found'
    end
    @followees = @user.followees.page(params[:page]).order('fullname DESC')
  end

  def followers
    @user = User.find_by(username: params[:username])
    unless @user
      render 'shared/not_found'
    end
    @followers = @user.followers.page(params[:page]).order('fullname DESC')
  end
end