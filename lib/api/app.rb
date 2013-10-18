module Api
  class App < Base
    attr_reader :name

    RAILS_APP_ATTRIBUTES = %W(dynos workers web_url released_at)
    def initialize(name)
      @name = name
    end

    def attributes
      @attribute ||= parse_body(client.get_app(@name).body) rescue {}
    end

    def addons
      @addons ||= client.get_addons(@name).body.map{|a| parse_body(a)} rescue []
    end


    private

    def parse_app(hash)
      HashWithIndifferentAccess.new(hash).keep_if do |k, v|
        RAILS_ATTRIBUTES.include?(k)
      end
    end

  end
end
