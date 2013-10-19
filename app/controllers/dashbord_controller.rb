class DashbordController < ApplicationController
  def index
    @api_infos = AppGroup.grouping
  end
end
