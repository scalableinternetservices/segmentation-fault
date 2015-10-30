class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :book]
  before_action :authenticate_user!, only: [:create, :book]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/book/1
  def book
    money = Transaction.create(price: @post.price)
    booking = Booking.create(user_id: current_user.id, transaction_id: money.id, post_id: @post.id)
    booking.save
  end

  # GET /posts/new
  def new
    @post = Post.new
    @cat = ["", "Apartment", "Event Space", "Hotel", "Mansion", "Service", "Other"]
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create

    # if !current_user
    #   respond_to do |format|
    #     format.html { render :new }
    #     format.json { render json: @post.errors, status: :unprocessable_entity }
    #   end
    # end

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
      params.require(:post).permit(:name, :image, :description, :price, :availability, :restrictions, :categories, :post_images)
    end
end
