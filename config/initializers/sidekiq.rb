heroku_setting = proc do |config|
  config.redis = { url: (ENV['REDISCLOUD_URL'] || 'redis://localhost:6379') }

  if database_url = ENV['DATABASE_URL']
    ENV['DATABASE_URL'] = "#{database_url}?pool=25"
    ActiveRecord::Base.establish_connection
  end
end

Sidekiq.configure_server do |config|
  config.poll_interval = 15
  heroku_setting.call(config)
end

Sidekiq.configure_client do |config|
  heroku_setting.call(config)
end
