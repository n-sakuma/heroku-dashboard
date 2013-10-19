class AppGroup < ActiveRecord::Base
  self.table_name = 'tags'

  def self.grouping
    grouping = {}
    pluck(:name).each do |k|
      grouping[k.to_sym] = HerokuApp.tagged_with(k)
    end
    grouping
  end
end

