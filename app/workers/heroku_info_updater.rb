class HerokuInfoUpdater
  include Sidekiq::Worker
  sidekiq_options :retry => 5, :backtrace => true

  sidekiq_retries_exhausted do |msg|
    Sidekiq.logger.warn "Failed #{msg['class']} with #{msg['args']}: #{msg['error_message']}"
  end

  def perform(id)
    app = HerokuApp.find(id)
    attr = Api::App.new(app.name).attributes
    app.update_attributes!(attr.merge(async_running: false))
  rescue => e
    Sidekiq.logger.warn "Faild: #{e.message}"
  end
end
