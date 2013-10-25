# Load the redis configuration from resque.yml
# Resque.redis = YAML.load_file(File.join(Rails.root, "config", "resque.yml"))[Rails.env.to_s]
# Resque.redis = ""
if Rails.env.development?
  Resque.redis = 'localhost:6379'
else
  Resque.redis = ENV['REDISTOGO_URL']
end
