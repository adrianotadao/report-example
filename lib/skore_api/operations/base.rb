module SkoreAPI
  module Operations
    class Base
      include HTTParty

      base_uri ENV['SKORE_API_URL']
      format :json
      parser OpenStructParser
      default_params access_token: ENV['SKORE_TOKEN']
    end
  end
end
