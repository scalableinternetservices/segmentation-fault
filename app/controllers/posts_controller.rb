require 'will_paginate/array'

class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :book, :check_user_is_owner, :check_user_not_owner]
  before_action :check_user_is_owner, only: [:edit, :update, :destroy]
  before_action :check_user_not_owner, only: [:book]
  before_action :authenticate_user!, only: [:create, :book]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.select{|p| p.booking == nil}.paginate(:page => params[:page]) if stale?(Post.select{|p| p.booking == nil}.paginate(:page => params[:page]))
  end

  def user_is_owner
    if current_user.id != @post.user_id
      head(401)
    end
  end

  def check_user_not_owner
    if current_user.id == @post.user_id
      head(401)
    end
  end

  def check_user_not_current_user
    if current_user.id != @post.user_id
      head(401)
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    fresh_when(@post)
  end

  # Post /posts/book/1
  def book
    user = User.find(params[:user_id])
    money = Transaction.create(price: @post.price)
    user.bookings.create(user_id: user.id, transaction_id: money.id, post_id: @post.id)
    respond_to do |format|
        format.html { redirect_to posts_path, notice: 'Booking was successfully created.' }
        format.json { head :no_content }
    end

  end
  helper_method :book

  # GET /posts/new
  def new
    @post = Post.new if stale?(Post.all)
    @cat = ["", "Apartment", "Event Space", "Hotel", "Mansion", "Service", "Other"]
  end

  # GET /posts/1/edit
  def edit
    @cat = ["", "Apartment", "Event Space", "Hotel", "Mansion", "Service", "Other"]
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.owner = current_user
    respond_to do |format|
      if @post.save
        if params[:images]
          params[:images].each do |image|
            @post.post_images.create(image: image)
          end
        end

        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    fresh_when(@post)
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:name, :description, :price, :availability, :restrictions, :categories, :post_images)
    end
end
