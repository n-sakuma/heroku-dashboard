class SessionsController < ApplicationController

  skip_before_action :require_heroku_login

  def new
  end

  def create
    access_token = request.env['omniauth.auth']['credentials']['token']
    if access_token.present?
      session[:heroku_access_token] = access_token
      redirect_to root_url, :notice => "Signed In!"
    else
      redirect_to login_path, :error => "failed"
    end
  end

  def destroy
    session[:heroku_access_token] = nil
    redirect_to root_url, :notice => "Signed Out!"
  end

end
