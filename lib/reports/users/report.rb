module Reports
  module Users
    class Report
      extend Memoist
      REPORT_PATH = "#{ ROOT }/tmp/users.csv".freeze

      def run!
        CSV.open(REPORT_PATH, 'w+') do |csv|
          csv << headers
          items.each { |item| csv << item.to_a }
        end
      end

      private

      def client
        SkoreAPI::Client.new
      end

      def users
        query = { only: %w(id name email) }
        client.user.index(query: query)
      end

      def items
        users.map { |user| build_item(user) }
      end

      def build_item(user)
        [user.id, user.name, user.email]
      end

      def headers
        %w(id name email)
      end

      memoize :client, :users, :items, :headers
    end
  end
end
