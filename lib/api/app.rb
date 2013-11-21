module Api
  class App
    attr_reader :name, :client

    IMPORT_APP_ATTR = %W(web_url released_at)
    IMPORT_ADDON_ATTR = %W(name description price plan_description group_description sso_url)
    IMPORT_PS_ATTR = {'process' => 'name', 'state' => 'status', 'release' => 'release_number', 'size' => 'size'}

    def initialize(name = "", token = nil)
      @name = name
      @client = Heroku::API.new(api_key: token)
    end

    def attributes
      app_info.merge(api_updatable: true, addon_count: addons.size).
        merge(addons_attributes: addons).
        merge(dynos_attributes: heroku_ps)
    end

    def app_info
      parse_body(client.get_app(@name).body, IMPORT_APP_ATTR) rescue {}
    end

    def self.app_names(token)
      self.new('', token).client.get_apps.body.map{|a| a['name']} rescue []
    end

    def addons
      client.get_addons(@name).body.map{|a| parse_body(a, IMPORT_ADDON_ATTR)} rescue []
    end

    def heroku_ps
      client.get_ps(@name).body.map do |ps|
        hs = {}
        ps.each do |k, v|
          next unless IMPORT_PS_ATTR.keys.include?(k)
          hs.store(IMPORT_PS_ATTR[k], v)
        end
        hs
      end
    end

    def exist?
      client.get_apps.body.map{|a| a["name"]}.include?(@name) rescue false
    end


    private

    def parse_body(hash, const)
      HashWithIndifferentAccess.new(hash).keep_if do |k, v|
        const.include?(k)
      end
    end
  end
end
