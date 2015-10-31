class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

  def profile
    @posts = Post.where("user_id = #{current_user.id}")
    @bookings = Booking.where("user_id = #{current_user.id}")
  end

end
