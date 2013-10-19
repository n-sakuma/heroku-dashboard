class Addon < ActiveRecord::Base
  belongs_to :app, class_name: 'HerokuApp'
end
