class AppGroupsController < ApplicationController

  def show
    unless @group = AppGroup.find_by(name: params[:tag])
      redirect_to(heroku_apps_path, alert: "Not found tag: #{params[:tag]}") and return
    end
    @groups = AppGroup.where.not(id: @group.id)
  end

  def dynos_status
    @app_groups = AppGroup.all
    respond_to do |format|
      format.json
    end
  end

  def addons_status
    @app_groups = AppGroup.all
    respond_to do |format|
      format.json
    end
  end
end
