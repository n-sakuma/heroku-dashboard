module Api
  class App < Base
    attr_reader :name

    RAILS_APP_ATTRIBUTES = %W(dynos workers web_url released_at)
    RAILS_ADDON_ATTRIBUTES = %W(name description price_cent plan_description group_description sso_url)

    def initialize(name)
      @name = name
    end

    def attributes
      @attribute ||= app_info.merge(api_updatable: true).merge(addons_attributes: addons)
    end

    def app_info
      @app_info ||= parse_app(client.get_app(@name).body) rescue {}
    end

    def addons
      @addons ||= client.get_addons(@name).body.map{|a| parse_addons(a)} rescue []
    end


    private

    def parse_app(hash)
      HashWithIndifferentAccess.new(hash).keep_if do |k, v|
        RAILS_APP_ATTRIBUTES.include?(k)
      end
    end

    def parse_addons(hash)
      hash[:price_cent] = hash['price']['cents']
      HashWithIndifferentAccess.new(hash).keep_if do |k, v|
        RAILS_ADDON_ATTRIBUTES.include?(k)
      end
    end

  end
end
