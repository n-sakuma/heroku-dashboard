class HerokuInfoUpdater
  @queue = :heroku_info_updater

  def self.perform(id)
    app = HerokuApp.find(id)
    app.update_api_attributes!
    # HerokuApp.send(method)
    # binding.pry
    # HerokuApp.multiple_update(async: true)
    # attr = Api::App.new(app.name).attributes.merge(async_running: true)
    # app.update_attributes(attr)
  rescue => e
    Rails.logger.warn "Failed: #{e.message}"
  end

  # def work(method)
  #   # binding.pry
  #   # HerokuApp.send(method)
  #   # HerokuApp.multiple_update
  # end

end
