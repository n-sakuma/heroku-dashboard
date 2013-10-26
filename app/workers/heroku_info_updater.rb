class HerokuInfoUpdater
  include Sidekiq::Worker

  def perform(id)
    sleep 1
    app = HerokuApp.find(id)
    attr = Api::App.new(app.name).attributes
    app.update_attributes!(attr.merge(async_running: false))
  rescue => e
    logger.warn "Faild: #{e.message}"
  end
end
