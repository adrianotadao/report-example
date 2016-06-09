module SkoreAPI
  module Operations
    class Base
      include HTTParty

      base_uri ENV['SKORE_API_URL']
      format :json
      parser OpenStructParser
      default_params access_token: ENV['SKORE_TOKEN']
      default_timeout 30
      MAX_RETRIES = 5
      RESCUE_FROM = [
        Errno::ECONNRESET, Errno::ECONNREFUSED, EOFError, Timeout::Error, SocketError
      ].freeze

      class << self
        extend Memoist

        def request(method, path, options = {})
          with_retries(max_tries: MAX_RETRIES, rescue: RESCUE_FROM) do |attempt|
            logger << "\n #{ method.upcase } #{ path } #{ options }  ##{ attempt }"
            send(method, path, options)
          end
        end

        private

        def logger
          Logger.new(STDOUT)
        end

        memoize :logger
      end
    end
  end
end
