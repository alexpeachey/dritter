class SessionsController < ApplicationController
  before_filter :require_login, only: [:destroy]
  
  def new
  end
  
  def create
    begin
      username = params[:username]
      username.downcase! if username.present?
      @user = User.find(username)
    rescue ActiveRecord::RecordNotFound
      handle_error and return
    else
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to root_url, notice: 'Signed In!'
      else
        handle_error and return
      end
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Signed Out!'
  end
  
  private
  def handle_error
    @error = 'Invalid username or password'
    flash.now[:error] = @error
    render :new
  end
end