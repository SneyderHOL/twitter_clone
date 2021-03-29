class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:home, :followees, :followers]
  before_action :set_current_user, only: [:follow, :follow_to]

  def home
    if @user && @user == current_user
      @user_tweets = get_tweets.paginate(page: params[:page], per_page: 10)
    elsif @user
      @user_tweets = @user.tweets.page(params[:page]).order('created_at DESC')
    else
      render_not_found
    end
  end

  def follow
  end

  def follow_to
    @followee = User.find_by(username: params[:followee])
    if @followee
      if @user.followees.include?(@followee)
        flash.now[:alert] = "You already follow #{ @followee.username }"
        render 'follow'
      else
        follow = Follow.create(follower: @user, followee: @followee)
        flash[:notice] = "You are now following #{ @followee.username }"
        redirect_to user_path(@followee.username)
      end
    else
      flash.now[:alert] = "The user #{ params[:followee] } does not exists"
      render 'follow'
    end
  end

  def followees
    unless @user
      render_not_found
      return
    end
    set_subjects @user.followees
  end

  def followers
    unless @user
      render_not_found
      return
    end
    set_subjects @user.followers
  end

  private

  def get_tweets
    tweets = @user.tweets.dup
    unless @user.followees.empty?
      @user.followees.each do |subject|
        tweets += subject.tweets.dup
      end
    end
    tweets.sort_by { |t| t.created_at }.reverse
  end

  def sort_subjects(subjects)
    subjects.sort { |subject_one, subject_two|
      subject_one.fullname.downcase <=> subject_two.fullname.downcase
    }
  end

  def set_user
    @user = User.find_by(username: params[:username])
  end

  def set_current_user
    @user = current_user
  end

  def set_subjects(subjects_list)
    @subjects = sort_subjects(subjects_list).paginate(page: params[:page], per_page: 10)
  end
end