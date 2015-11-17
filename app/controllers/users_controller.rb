require 'will_paginate/array'

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :profile]

  def index
    @users = User.all.paginate(:page => params[:page])
  end

  def show
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

  def profile
    @posts = @user.posts.paginate(:page => params[:page])
    @bookings = @user.bookings.paginate(:page => params[:page])
    end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

end
