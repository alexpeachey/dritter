class UsersController < ApplicationController
  before_filter :require_login, only: [:edit, :update, :destroy]
  before_filter :verify_control, only: [:edit, :update, :destroy]

  def index
    @users = UserDecorator.all

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def followers
    @user = UserDecorator.find(params[:id])
    @users = @user.followers

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end
  
  def followings
    @user = UserDecorator.find(params[:id])
    @users = @user.followings

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def show
    @user = UserDecorator.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def edit
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to edit_user_path(@user), notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
  
  private
  def verify_control
    @user = User.find(params[:id])
    not_authorized unless @user == current_user.model
  end
end
