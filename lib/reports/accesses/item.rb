module Reports
  module Accesses
    class Item
      extend Memoist
      attr_reader :access

      def initialize(access)
        @access = access
      end

      def user
        Reports::Accesses::Finders.find_user(access)
      end

      def departments
        Reports::Accesses::Finders.find_departments(access)
      end

      def lesson
        Reports::Accesses::Finders.find_lesson(access)
      end

      def to_a
        return if user.blank?
        created_at = Date.parse(access.created_at)
        [
          access.created_at,
          created_at.year,
          created_at.month,
          created_at.day,
          user.id,
          user.name,
          user.email,
          departments.map(&:name).join(' | '),
          lesson.try(:category).try(:template),
          lesson.try(:category).try(:name),
          lesson.try(:board).try(:name),
          lesson.try(:title)
        ]
      end

      memoize :user, :departments, :lesson, :to_a
    end
  end
end
