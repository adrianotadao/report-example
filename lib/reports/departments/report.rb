module Reports
  module Departments
    class Report
      extend Memoist
      REPORT_PATH = "#{ ROOT }/tmp/departments.csv".freeze

      def run!
        CSV.open(REPORT_PATH, 'w+') do |csv|
          csv << headers
          items.each do |item|
            row = item.to_a
            csv << row if row.present?
          end
        end
      end

      private

      def client
        SkoreAPI::Client.new
      end

      def departments
        query = { only: %w(id name total_users) }
        client.department.index(query: query)
      end

      def items
        departments.map { |department| build_item(department) }
      end

      def build_item(department)
        [department.id, department.name, department.total_users]
      end

      def headers
        %w(id name total_users)
      end

      memoize :client, :departments, :items, :headers
    end
  end
end
