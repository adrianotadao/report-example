module Reports
  module UserDepartments
    class Report
      extend Memoist
      REPORT_PATH = "#{ ROOT }/tmp/user_departments.csv".freeze

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

      def departments
        query = { only: %w(id name) }
        client.department.index(query: query)
      end

      def users
        query = { only: %w(id name department_ids) }
        client.user.index(query: query)
      end

      def items
        Array.new.tap do |items|
          users.each { |user| items.concat(build_item(user)) }
        end.compact.uniq
      end

      def build_item(user)
        user_departments(user).map do |department|
          [department.id, department.name, user.id, user.name]
        end
      end

      def user_departments(user)
        departments.select do |department|
          user.department_ids.to_a.include?(department.id)
        end
      end

      def headers
        %w(department_id department_name user_id user_name)
      end

      memoize :client, :departments, :users, :items, :headers
    end
  end
end
