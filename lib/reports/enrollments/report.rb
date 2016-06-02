module Reports
  module Enrollments
    class Report
      extend Memoist
      REPORT_PATH = "#{ ROOT }/tmp/enrollments.csv".freeze

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

      def categories
        query = { only: %w(id name) }
        client.category.index(query: query)
      end

      def users
        query = { only: %i(id name), per_page: 1_000 }
        client.user.index(query: query)
      end

      def items
        enrollments.map { |enrollment| build_item(enrollment) }.compact.uniq
      end

      def enrollments
        query = { only: %w(category_id user_id grade progress created_at) }
        client.enrollment.index(query: query)
      end

      def build_item(enrollment)
        category_id = enrollment.delete_field(:category_id)
        user_id = enrollment.delete_field(:user_id)
        enrollment.category = categories.detect { |category| category.id == category_id }
        enrollment.user = users.detect { |user| user.id == user_id }
        return if enrollment.category.blank? || enrollment.user.blank?
        Reports::Enrollments::Item.new(enrollment)
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

      memoize :client, :categories, :users, :enrollments, :items
    end
  end
end
