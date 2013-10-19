module Api
  class App < Base
    attr_reader :name

    RAILS_APP_ATTR = %W(dynos workers web_url released_at)
    RAILS_ADDON_ATTR = %W(name description price plan_description group_description sso_url)

    def initialize(name)
      @name = name
    end

    def attributes
      @attribute ||= app_info.merge(api_updatable: true).merge(addons_attributes: addons)
    end

    def app_info
      @app_info ||= parse_body(client.get_app(@name).body, RAILS_APP_ATTR) rescue {}
    end

    def addons
      @addons ||= client.get_addons(@name).body.map{|a| parse_body(a, RAILS_ADDON_ATTR)} rescue []
    end


    private

    def parse_body(hash, const)
      HashWithIndifferentAccess.new(hash).keep_if do |k, v|
        const.include?(k)
      end
    end

  end
end
