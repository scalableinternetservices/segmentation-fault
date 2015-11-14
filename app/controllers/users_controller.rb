class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :profile]

  def index
    @users = User.all if stale?(User.all)
  end

  def show
    fresh_when(@user)
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

  def edit
    fresh_when(@user)
  end

  def profile
    @posts = @user.posts if stale?(@user.posts)
    @bookings = @user.bookings if stale?(@user.bookings)
  end

  private
  def set_user
    @user = User.find(params[:id])
  end


end
