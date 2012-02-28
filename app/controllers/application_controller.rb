class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_current_user
  helper_method :current_user

  def current_user
    @current_user ||= User.anonymous
  end

  def current_user=(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def destroy_user!
    session.delete :user_id
    current_user.destroy
  end

  def set_current_user
    self.current_user = session.has_key?(:user_id) ? User.find(session[:user_id]) : User.anonymous
  end
end
