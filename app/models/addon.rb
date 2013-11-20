class Addon < ActiveRecord::Base
  belongs_to :app, class_name: 'HerokuApp'

  def price_doller
    return 0 if price['cents'].to_i.zero?
    price['cents'].to_i / 100
  end
end
