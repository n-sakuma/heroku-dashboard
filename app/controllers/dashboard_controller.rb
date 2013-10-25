class DashboardController < ApplicationController
  def index
    @app_groups = AppGroup.all
  end

  def async_update
    # HerokuApp.async
    HerokuApp.all.each do |app|
      app.update_attribute(:async_running, true)
      app.async
    end
    # resque = Resque.new
    # resque << HerokuInfoUpdater.new
    redirect_to root_path, info: "async.."
  end
end
