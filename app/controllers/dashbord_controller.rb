class DashbordController < ApplicationController
  def index
    @api_infos = {}
    HerokuAppKind.pluck(:name).each do |k|
      @api_infos[k.to_sym] = HerokuApp.tagged_with(k).map{|a| Api::App.new(a.name)}
    end
  end
end
