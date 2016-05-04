class Report
  extend Memoist
  REPORT_PATH = File.expand_path('../../tmp/report.csv', __FILE__).freeze
  autoload :Item, './lib/report/item'

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

  def categories
    client.category.index(query: { only: %w(id name) }).parsed_response
  end

  def users
    query = { only: %w(id name email), per_page: 100_000 }
    client.user.index(query: query).parsed_response['users']
  end

  def items
    enrollments.map { |enrollment| build_item(enrollment) }
  end

  def enrollments
    query = { only: %w(category_id user_id grade progress created_at) }
    client.enrollment.index(query: query).parsed_response['enrollments']
  end

  def build_item(enrollment)
    category_id = enrollment.delete_field(:category_id)
    user_id = enrollment.delete_field(:user_id)
    enrollment.category = categories.find { |category| category.id == category_id }
    enrollment.user = users.find { |user| user.id == user_id }
    Report::Item.new(enrollment)
  end

  def headers
    %w(
      category_name
      user_name
      started_at
      grade
      progress
      completed_lessons
      last_access
      duration
      access_count
    )
  end

  memoize :client, :categories, :users, :enrollments, :items
end
