Sidekiq.configure_server do |config|
  config.poll_interval = 15

  config.redis = { url: (ENV['REDISCLOUD_URL'] || 'redis://localhost:6379') }

  # for Heroku
  database_url = ENV['DATABASE_URL']
  if database_url
    ENV['DATABASE_URL'] = "#{database_url}?pool=25"
    ActiveRecord::Base.establish_connection
  end

end
