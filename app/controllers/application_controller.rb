class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_current_user
  helper_method :current_user

  def current_user
    @current_user ||= User.anonymous
  end

  def current_user=(user)
    @current_user = user
  end

  def set_current_user
    self.current_user = session.has_key?(:username) ? User.new(session[:username]) : User.anonymous
  end
end
