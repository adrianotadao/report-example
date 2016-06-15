module Reports
  module Worksheets
    class Item
      extend Memoist

      def initialize(worksheet)
        @worksheet = worksheet
      end

      def user
        Reports::Worksheets::Finders.find_user(@worksheet)
      end

      def departments
        Reports::Worksheets::Finders.find_departments(@worksheet)
      end

      def lesson
        Reports::Worksheets::Finders.find_lesson(@worksheet)
      end

      def to_a
        return if @worksheet.memorized_answers.blank?
        @worksheet.memorized_answers.map do |memorized_answer|
          build_memorized_answer(memorized_answer)
        end
      end

      def build_memorized_answer(memorized_answer)
        return if user.blank?
        [
          departments.map(&:name).join(' | '),
          user.name,
          user.email,
          lesson.try(:category).try(:name),
          lesson.try(:board).try(:name),
          lesson.try(:title),
          memorized_answer.format,
          memorized_answer.description,
          memorized_answer.answer,
          memorized_answer.acceptance
        ]
      end

      memoize :user, :departments, :lesson, :to_a
    end
  end
end
