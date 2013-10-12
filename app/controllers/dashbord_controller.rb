class DashbordController < ApplicationController
  def index
    heroku = Heroku::API.new(api_key: ENV['API_KEY'])
    res = heroku.get_apps
    if res.status == 200
      @apps = res.body.map{|app| HerokuApp.new(app)}
    else
      #...
    end
  end
end
