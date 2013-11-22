class HerokuAppsController < ApplicationController
  before_action :set_heroku_app, only: [:show, :edit, :update, :update_api, :destroy]

  def index
    @heroku_apps = HerokuApp.order(:name)
  end

  def show
  end

  def new
    @app_names = Api::App.app_names(current_user.access_token) - HerokuApp.pluck(:name)
  end

  def edit
  end

  def multiple_create
    result = HerokuApp.multiple_create(multiple_app_params, current_user.access_token)
    redirect_to heroku_apps_path, notice: result[:success], alert: result[:failed]
  end

  def multiple_update
    HerokuApp.all_async!(current_user.access_token)
    render json: {}, status: :ok
  end

  def update
    if @heroku_app.update(heroku_app_params)
      redirect_to @heroku_app, notice: 'Heroku app was successfully updated.'
    else
      render :edit
    end
  end

  def update_api
    @heroku_app.async_get_api!
    render json: {}, status: :ok
  rescue => e
    logger.warn "#{e.message}"
    redirect_to heroku_app_path(@heroku_app), alert: "Failed: #{e.message}"
  end

  def destroy
    @heroku_app.destroy
    redirect_to heroku_apps_url
  end


  private

  def set_heroku_app
    @heroku_app = HerokuApp.find(params[:id])
    @heroku_app.auth_token = current_user.access_token
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def heroku_app_params
    params.require(:heroku_app).permit(:name, :tag_list)
  end

  def multiple_app_params
    params[:apps].select{|k, v| v.has_key?(:name)}
  end
end
