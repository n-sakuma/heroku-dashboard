class HerokuInfoUpdater
  def initialize(id)
    @heroku_app_id = id
  end

  def run
    # sleep 1
    app = HerokuApp.find(@heroku_app_id)
    attr = Api::App.new(app.name).attributes
    app.update_attributes!(attr.merge(async_running: false))
  rescue => e
    logger.warn "Faild: #{e.message}"
  end
end
