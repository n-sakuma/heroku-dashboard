module Api
  class Base

    def client
      @heroku_client ||= build_client
    end

    def reload!
      @heroku_client = build_client
    end


    private

    def build_client
      Heroku::API.new(api_key: ENV['API_KEY'])
    end
  end
end
