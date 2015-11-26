require 'will_paginate/array'

class PostImagesController < ApplicationController
  before_action :set_post_image, only: [:show, :edit, :update, :destroy]

  # GET /post_images
  # GET /post_images.json
  def index
    @post_images = PostImage.all.paginate(:page => params[:page]) if stale?(PostImage.all.paginate(:page => params[:page]))
  end

  # GET /post_images/1
  # GET /post_images/1.json
  def show
    fresh_when(@post_image)
  end

  def book
  end

  # GET /post_images/new
  def new
    @post_image = PostImage.new(post_id: params[:post_id]) if stale?(PostImages.all)
    all_posts = Post.all if stale?(Post.all)
    @options = all_posts.collect do |s|
      [s.name, s.id]
    end
  end

  # GET /post_images/1/edit
  def edit
    @options = Post.find(:all,
                            :order => "name").
    collect do |s|
      [s.name, s.id]
    end
  end

  # POST /post_images
  # POST /post_images.json
  def create
    @post_image = PostImage.new(post_image_params)

    respond_to do |format|
      if @post_image.save
        format.html { redirect_to @post_image, notice: 'Post image was successfully created.' }
        format.json { render :show, status: :created, location: @post_image }
      else
        format.html { render :new }
        format.json { render json: @post_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /post_images/1
  # PATCH/PUT /post_images/1.json
  def update
    fresh_when(@post_image)
    respond_to do |format|
      if @post_image.update(post_image_params)
        format.html { redirect_to @post_image, notice: 'Post image was successfully updated.' }
        format.json { render :show, status: :ok, location: @post_image }
      else
        format.html { render :edit }
        format.json { render json: @post_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_images/1
  # DELETE /post_images/1.json
  def destroy
    @post_image.destroy
    respond_to do |format|
      format.html { redirect_to post_images_url, notice: 'Post image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_image
      @post_image = PostImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_image_params
      params.require(:post_image).permit(:image_url, :post_id)
    end
end
