module Api
  class App < Base
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def attributes
      @attribute ||= parse_body(client.get_app(@name).body) rescue {}
    end

    def addons
      @addons ||= client.get_addons(@name).body.map{|a| parse_body(a)} rescue []
    end
  end
end
