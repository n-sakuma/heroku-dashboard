class HerokuAppsController < ApplicationController
  before_action :set_heroku_app, only: [:show, :edit, :update, :update_api, :destroy]

  def index
    @heroku_apps = HerokuApp.order(:name)
  end

  def show
  end

  def new
    @heroku_app = HerokuApp.new
  end

  def unregistered_apps
    @app_names = Api::App.app_names - HerokuApp.pluck(:name)
    render layout: false #, status: :ok
    # render layout: (request.headers["X-Requested-With"] != 'XMLHttpRequest')
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

  def multiple_create
    # binding.pry
    params[:apps].values.each do |app|
      HerokuApp.create(name: app)
    end
    redirect_to heroku_apps_path, notice: 'created'
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
    @heroku_app.update_attributes!(attr)
    msg = 'Heroku app was successfully updated.'
    redirect_to heroku_app_path(@heroku_app), notice: msg
  rescue => e
    logger.warn "#{e.message}"
    redirect_to heroku_app_path(@heroku_app), alert: 'Failed API Update.'
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
