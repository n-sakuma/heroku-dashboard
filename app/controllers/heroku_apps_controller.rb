class HerokuAppsController < ApplicationController
  before_action :set_heroku_app, only: [:show, :edit, :update, :update_api, :destroy]

  def index
    @heroku_apps = HerokuApp.all
  end

  def show
  end

  def new
    @heroku_app = HerokuApp.new
  end

  def edit
  end

  def create
    @heroku_app = HerokuApp.new(heroku_app_params)

    if @heroku_app.save
      redirect_to @heroku_app, notice: 'Heroku app was successfully created.'
    else
      render :new
    end
  end

  def update
    if @heroku_app.update(heroku_app_params)
      redirect_to @heroku_app, notice: 'Heroku app was successfully updated.'
    else
      render :edit
    end
  end

  def update_api
    attr = Api::App.new(@heroku_app.name).attributes
    if @heroku_app.update_attributes(attr)
      msg = 'Heroku app was successfully updated.'
    else
      msg = 'failed'
    end
  rescue => e
    logger.warn "#{e.message}"
    msg = 'failed'
  ensure
    redirect_to heroku_app_path(@heroku_app), notice: msg
  end

  def destroy
    @heroku_app.destroy
    redirect_to heroku_apps_url
  end


  private

  def set_heroku_app
    @heroku_app = HerokuApp.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def heroku_app_params
    params.require(:heroku_app).permit(:name, :tag_list)
  end
end
