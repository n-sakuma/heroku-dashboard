class DashbordController < ApplicationController
  def index
    @app_group = AppGroup.grouping
  end
end
