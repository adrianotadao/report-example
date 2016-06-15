module Reports
  module Accesses
    class Report
      extend Memoist
      REPORT_PATH = "#{ ROOT }/tmp/accesses.csv".freeze

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

      def accesses
        query = { only: %w(created_at lesson_id user_id), per_page: 1_000 }
        client.access.index(query: query)
      end

      def items
        accesses.map { |access| Reports::Accesses::Item.new(access) }
      end

      def headers
        %w(
          created_at
          year
          month
          day
          user_id
          user_name
          user_email
          user_departments
          category_template
          category_name
          board_name
          lesson_title
        )
      end

      memoize :client, :accesses, :items, :headers
    end
  end
end
