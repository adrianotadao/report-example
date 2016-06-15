module Reports
  module Worksheets
    class Report
      extend Memoist
      REPORT_PATH = "#{ ROOT }/tmp/worksheets.csv".freeze

      def run!
        CSV.open(REPORT_PATH, 'w+') do |csv|
          csv << headers
          items.to_a.each do |item|
            row = item.to_a
            csv << row if row.present?
          end
        end
      end

      private

      def client
        SkoreAPI::Client.new
      end

      def worksheets
        query = {
          evaluated: true,
          only: %w(lesson_id student_id grade memorized_answers),
          per_page: 1_000
        }
        client.worksheet.index(query: query)
      end

      def items
        return if worksheets.blank?
        Array.new.tap do |items|
          worksheets.each do |worksheet|
            item = Reports::Worksheets::Item.new(worksheet)
            next if item.to_a.blank?
            items.concat(item.to_a)
          end
        end.compact.uniq
      end

      def headers
        %w(
          department_name
          user_id
          user_email
          category_name
          board_name
          lesson
          question_format
          question_description
          answer
          correct?
        )
      end

      memoize :client, :worksheets, :items, :headers
    end
  end
end
