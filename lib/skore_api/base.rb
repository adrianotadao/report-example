module SkoreAPI
  class Base
    include HTTParty
    base_uri ENV['SKORE_API_URL']
    format :json
    parser OpenStructParser

    def initialize(access_token)
      self.class.default_params[:access_token] = access_token
    end
  end
end
