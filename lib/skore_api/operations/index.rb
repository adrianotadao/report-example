module SkoreAPI
  module Operations
    class Index < Base
      default_params per_page: 100

      class << self
        def run(path, options = {})
          response = get(path, options)
          SkoreAPI::Request::Collection.new(response)
        end

        def all(path, options = {})
          options[:query] ||= {}
          options[:query][:page] = 1
          resources = []
          last_request = nil

          loop do
            last_request = run(path, options)
            resources.concat(last_request.all)
            options[:query][:page] = last_request.current_page + 1
            break unless last_request.current_page < last_request.total_pages
          end
          resources
        end
      end
    end
  end
end
