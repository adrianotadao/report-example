module Reports
  module Enrollments
    class Item
      extend Memoist
      attr_reader :category_name, :user_name, :started_at, :last_access

      def initialize(enrollment)
        @enrollment = enrollment
      end

      def category_name
        category.name
      end

      def user_name
        user.name
      end

      def started_at
        @enrollment.created_at
      end

      def grade
        @enrollment.grade.to_f.round(1)
      end

      def progress
        @enrollment.progress.to_i
      end

      def completed_lessons
        query = { category_id: category.id, completed_by: user.id, only: %w(id) }
        client.lesson.index(query: query).parsed_response.try(:size).to_i
      end

      def last_access
        return if accesses.blank?
        accesses.first.try(:created_at)
      end

      def duration
        return if accesses.blank?
        accesses.map { |access| access.lesson.duration.to_i }.sum
      end

      def access_count
        return 0 if accesses.blank?
        accesses.size.to_i
      end

      def to_a
        [
          category_name,
          user_name,
          started_at,
          grade,
          progress,
          completed_lessons,
          last_access,
          duration,
          access_count
        ]
      end

      private

      def client
        SkoreAPI::Client.new
      end

      def user
        @enrollment.user
      end

      def category
        @enrollment.category
      end

      def accesses
        query = {
          by_categories: category.id,
          user_id: user.id,
          recent: true,
          only: %w(created_at lesson.duration)
        }
        client.access.index(query: query).parsed_response
      end

      memoize :client, :user, :category, :accesses, :completed_lessons,
              :last_access, :duration, :access_count
    end
  end
end
