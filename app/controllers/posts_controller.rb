class PostsController < ApplicationController
  before_filter :require_login, only: [:new, :create, :destroy]
  before_filter :find_post, only: [:show, :destroy]

  def index
    @posts = if current_user.signed_in? then Post.timeline(current_user.model).recent else Post.recent end
    @posts = PostDecorator.decorate(@posts)

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show

    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end

  def new
    @post = Post.new

    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end

  def create
    @post = current_user.posts.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_url, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy if has_control?

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :ok }
    end
  end
  
  private
  def find_post
    @post = PostDecorator.find(params[:id])
  end
  
  def has_control?
    current_user && @post && current_user == @post.user
  end
end
