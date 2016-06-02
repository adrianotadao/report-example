module Reports
  module Accesses
    class Finders
      class << self
        extend Memoist

        def find_user(access)
          users.detect { |user| user.id == access.user_id }
        end

        def find_departments(user)
          departments.select { |department| department.user_ids.include?(user.id) }
        end

        def find_lesson(access)
          lessons.detect { |lesson| lesson.id == access.lesson_id }
        end

        private

        def users
          query = { only: %i(id name email) }
          client.user.index(query: query)
        end

        def departments
          query = { only: %i(id name user_ids) }
          client.department.index(query: query)
        end

        def lessons
          query = { only: %i(id title board.name category.name category.template) }
          client.lesson.index(query: query)
        end

        def client
          SkoreAPI::Client.new
        end

        memoize :client, :users, :departments, :lessons, :find_user, :find_departments, :find_lesson
      end
    end
  end
end
