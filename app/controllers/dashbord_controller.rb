class DashbordController < ApplicationController
  def index
    @apps = HerokuApp.all.map{|a| Api::App.new(a.name)}
  end
end
