class HerokuApp < ActiveRecord::Base
  acts_as_taggable

  attr_accessor :api_updatable

  has_many :addons, dependent: :destroy
  accepts_nested_attributes_for :addons, allow_destroy: true
  has_many :dynos, dependent: :destroy
  accepts_nested_attributes_for :dynos, allow_destroy: true

  before_save :reset_resources

  validates :name, presence: true

  def dynos_summary
    dynos_kind_dup = dynos_kind.dup
    total = dynos_kind_dup.delete(:total)
    dynos_desc = dynos_kind_dup.to_a.map do |d|
      "#{d.first}: #{d.last.to_a.join('x ')}"
    end
    "#{total} (#{dynos_desc.join(', ')})"
  end

  def dynos_kind
    dynos_dup = dynos.dup
    uniq_keys = dynos_dup.map{|d| d.name.sub(/\..*/, '')}.sort.uniq
    hs = {}
    uniq_keys.map do |key|
      match_dynos = dynos_dup.select{|d| d.name =~ Regexp.new("#{key}.*")}
      hs[key] = {"#{match_dynos.first.size}" => match_dynos.size}
    end
    hs.merge(total: dynos_dup.map(&:size).sum)
  end

  def dynos_statuses
    dynos_dup = dynos
    dynos_dup.map(&:status)
  end

  def dynos_status_score
    return -1 if dynos_statuses.empty?
    all_status = dynos_statuses.size.to_f
    ok = dynos_statuses.select{|s| s == "up"}.size.to_f
    (ok / all_status) * 100
  end

  def addon_cost
    addons.inject(0){|sum, addon| sum += addon.price_doller }
  end


  private

  def reset_resources
    if api_updatable
      addons.where.not(created_at: nil).delete_all
      dynos.where.not(created_at: nil).delete_all
    end
  end
end
