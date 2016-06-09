module Reports
  module Enrollments
    class Report
      extend Memoist
      REPORT_PATH = "#{ ROOT }/tmp/enrollments.csv".freeze
      THREADS = 40

      def run!
        csv << headers
        proccess_items
      end

      private

      def client
        SkoreAPI::Client.new
      end

      def csv
        CSV.open(REPORT_PATH, 'w+')
      end

      def items
        enrollments.map do |enrollment|
          Reports::Enrollments::Item.new(enrollment)
        end.compact.uniq
      end

      def enrollments
        query = { only: %w(category_id user_id grade progress created_at), per_page: 500 }
        client.enrollment.index(query: query)
      end

      def proccess_items
        cache_requests!

        Thread.pool(THREADS).tap do |pool|
          items.each do |item|
            pool.process { proccess_item(item) }
          end
          pool.shutdown
        end
      end

      def cache_requests!
        Reports::Enrollments::Finders.accesses
        Reports::Enrollments::Finders.categories
        Reports::Enrollments::Finders.users
        Reports::Enrollments::Finders.lessons
      end

      def proccess_item(item)
        row = item.to_a
        return if row.blank?
        csv << row
      end

      def headers
        %w(
          category_name
          user_name
          started_at
          grade
          progress
          completed_lessons
          last_access
          duration
          access_count
        )
      end

      memoize :client, :csv, :enrollments, :items
    end
  end
end
