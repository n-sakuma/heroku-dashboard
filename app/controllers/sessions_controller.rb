class SessionsController < ApplicationController

  skip_before_action :require_heroku_login

  def new
  end

  def create
    access_token = request.env['omniauth.auth']['credentials']['token']
    user_email = get_user_email(access_token)
    raise "Not found user: #{user_email}" unless user = User.find_by(email: user_email)
    user.update_attributes!(access_token: access_token, access_token_expired_at: 1.hour.from_now)
    self.current_user = user
    redirect_to root_path, notice: "Signed In!"
  rescue => e
    logger.warn "Auth Error: #{e.message}"
    redirect_to login_path, alert: e.message
  end

  def destroy
    session[:heroku_access_token] = nil
    redirect_to root_url, notice: "Signed Out!"
  end

  private

  def get_user_email(token)
    raise "Could not get the access token" unless token.present?
    api = Excon.new(ENV["HEROKU_API_URL"] || "https://api.heroku.com",
      headers: { "Authorization" => "Bearer #{token}" },
      ssl_verify_peer: ENV["SSL_VERIFY_PEER"] != "false")
    res = api.get(path: "/account", expects: 200)
    MultiJson.decode(res.body)["email"]
  end

end
