module Reports
  module Worksheets
    class Report
      extend Memoist
      REPORT_PATH = "#{ ROOT }/tmp/worksheets.csv".freeze

      def run!
        CSV.open(REPORT_PATH, 'w+') do |csv|
          csv << headers
          items.each do |item|
            item.to_a.each { |r| csv << r }
          end
        end
      end

      private

      def client
        SkoreAPI::Client.new
      end

      def worksheets
        query = { evaluated: true, only: %w(lesson_id student_id grade memorized_answers) }
        client.worksheet.index(query: query).parsed_response
      end

      def items
        worksheets.map { |worksheet| Reports::Worksheets::Item.new(worksheet) }
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
