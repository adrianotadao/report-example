module Reports
  module Worksheets
    class Finders
      class << self
        extend Memoist

        def find_user(worksheet)
          users.find { |user| user.id == worksheet.student_id }
        end

        def find_departments(user)
          departments.find_all { |department| department.user_ids.include?(user.id) }
        end

        def find_lesson(worksheet)
          lessons.find { |lesson| lesson.id == worksheet.lesson_id }
        end

        private

        def users
          query = { only: %i(id name email) }
          client.user.index(query: query).parsed_response
        end

        def departments
          query = { only: %i(id name user_ids) }
          client.department.index(query: query).parsed_response
        end

        def lessons
          query = { only: %i(id title board.name category.name) }
          client.lesson.index(query: query).parsed_response
        end

        def client
          SkoreAPI::Client.new
        end

        memoize :client, :users, :departments, :lessons, :find_user, :find_departments, :find_lesson
      end
    end
  end
end
