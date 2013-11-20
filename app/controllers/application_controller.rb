class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_heroku_login


  private

  def require_heroku_login
    redirect_to(:login, error: 'login failed!') if session[:heroku_access_token].blank?
  end
end
