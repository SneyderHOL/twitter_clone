class TweetsController < ApplicationController
  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(params.require(:tweet).permit(:message))
    @tweet.user = current_user
    if @tweet.save
      flash[:notice] = "Your tweet was successfully saved"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def index
  end
end
