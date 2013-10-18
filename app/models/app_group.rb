class AppGroup < ActiveRecord::Base
  self.table_name = 'tags'

  def self.grouping
    grouping = {}
    pluck(:name).each do |k|
      grouping[k.to_sym] = HerokuApp.tagged_with(k).map{|a| Api::App.new(a.name)}
    end
    grouping
  end
end

