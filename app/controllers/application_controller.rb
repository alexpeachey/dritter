class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  before_filter :set_timezone
  helper_method :current_user
  
  protected
  def not_found
    flash[:error] = "Unfortunately it looks like you took a wrong turn."
    redirect_to root_url
  end
  
  def set_timezone
    min = request.cookies["time_zone"].to_i
    Time.zone = ActiveSupport::TimeZone[-min.minutes]
  end
  
  private
  def current_user
    @current_user ||= UserDecorator.find(session[:user_id]) if session[:user_id]
    @current_user ||= UserDecorator.new(User.new)
  end
  
  def require_login
    not_authenticated unless current_user.present?
  end
  
  def not_authenticated
    flash[:warning] = 'Please login or create an account.'
    redirect_to sign_in_path
  end
end
