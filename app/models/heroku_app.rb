class HerokuApp < ActiveRecord::Base
  acts_as_taggable

  attr_accessor :api_updatable

  has_many :addons, dependent: :destroy
  accepts_nested_attributes_for :addons, :allow_destroy => true

  before_save :reset_addon

  def addon_cost
    addons.inject(0){|sum, addon| sum += addon.price_doller }
  end

  private

  def reset_addon
    addons.where.not(:created_at => nil).delete_all if api_updatable
  end
end
