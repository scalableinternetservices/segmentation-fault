class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :profile]

  def index
    @users = User.all
  end

  def show
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

  def profile
    @posts = @user.posts if stale?(@user.posts)
    @bookings = @user.bookings if stale?(@user.bookings)
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

end
