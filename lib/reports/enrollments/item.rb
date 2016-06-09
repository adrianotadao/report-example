module Reports
  module Enrollments
    class Item
      extend Memoist
      attr_reader :enrollment

      def initialize(enrollment)
        @enrollment = enrollment
      end

      def started_at
        enrollment.created_at
      end

      def grade
        enrollment.grade.to_f.round(1)
      end

      def progress
        enrollment.progress.to_i
      end

      def completed_lessons
        query = { category_id: category.id, completed_by: user.id, only: %w(id) }
        client.lesson.index(query: query).try(:size).to_i
      end

      def last_access
        return if accesses.blank?
        accesses.first.try(:created_at)
      end

      def duration
        return if accesses.blank?
        accesses.map do |access|
          lesson = Reports::Enrollments::Finders.find_lesson(access.lesson_id)
          next unless lesson.duration
          lesson.duration.to_i
        end.sum
      end

      def access_count
        return 0 if accesses.blank?
        accesses.size.to_i
      end

      def to_a
        return if category.blank? || user.blank?
        [
          category.name,
          user.name,
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
        Reports::Enrollments::Finders.find_user(enrollment.user_id)
      end

      def category
        Reports::Enrollments::Finders.find_category(enrollment.category_id)
      end

      def accesses
        Reports::Enrollments::Finders.find_accesses(category.id, user.id)
      end

      memoize :client, :user, :category, :accesses, :completed_lessons,
              :last_access, :duration, :access_count
    end
  end
end
