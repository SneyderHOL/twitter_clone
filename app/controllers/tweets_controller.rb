class TweetsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      flash[:notice] = "Your tweet was successfully saved"
      redirect_to user_path(current_user.username)
    else
      render 'new'
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:message)
  end
end
