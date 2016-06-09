module Reports
  module Enrollments
    class Finders
      class << self
        extend Memoist

        def find_accesses(category_id, user_id)
          accesses.select { |access| access.category_id == category_id && access.user_id = user_id }
        end

        def find_category(category_id)
          categories.detect { |category| category.id == category_id }
        end

        def find_user(user_id)
          users.detect { |user| user.id == user_id }
        end

        def find_lesson(lesson_id)
          lessons.detect { |lesson| lesson.id == lesson_id }
        end

        def accesses
          query = { per_page: 1_000, recent: true, only: %w(created_at lesson_id) }
          client.access.index(query: query)
        end

        def categories
          query = { only: %i(id name) }
          client.category.index(query: query)
        end

        def users
          query = { only: %i(id name), per_page: 1_000 }
          client.user.index(query: query)
        end

        def lessons
          query = { only: %i(id title board.name category.name category.template) }
          client.lesson.index(query: query)
        end

        private

        def client
          SkoreAPI::Client.new
        end

        memoize :client, :accesses, :categories, :users, :lessons,
                :find_accesses, :find_category, :find_user, :find_lesson
      end
    end
  end
end
