class RelationshipsController < ApplicationController
  before_filter :require_login

  def create
    @user = UserDecorator.find(params[:user_id])
    current_user.model.follow!(@user)
    @user.model.reload
    
    respond_to do |format|
      format.html { redirect_to @user, notice: "#{@user.username} followed!" }
      format.json { render json: @relationship, status: :created, location: @relationship }
      format.js
    end
  end

  def destroy
    @user = UserDecorator.find(params[:user_id])
    current_user.model.unfollow!(@user)
    @user.model.reload

    respond_to do |format|
      format.html { redirect_to @user, notice: "Stopped following #{@user.username}" }
      format.json { head :ok }
      format.js
    end
  end
end
