module SkoreAPI
  module Request
    class Collection
      attr_reader :response, :resources

      def initialize(response)
        @response = response
      end

      def all
        response.parsed_response
      end

      def current_page
        response.headers['current-page'].to_i
      end

      def total_pages
        response.headers['total-pages'].to_i
      end
    end
  end
end
