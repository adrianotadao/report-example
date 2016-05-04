class Report
  extend Memoist

  autoload :Item, './lib/report/item'

  def run!
    byebug
    items.first(10).each do |item|
      p item.to_a
    end
    byebug
  end

  private

  def items
    enrollments.map { |enrollment| build_item(enrollment) }
  end

  def build_item(enrollment)
    category_id = enrollment.delete_field(:category_id)
    user_id = enrollment.delete_field(:user_id)
    enrollment.category = categories.find { |category| category.id == category_id }
    enrollment.user = users.find { |user| user.id == user_id }
    Report::Item.new(enrollment)
  end

  def categories
    client.category.index(query: { only: %w(id name) }).parsed_response
  end

  def users
    query = { only: %w(id name email), per_page: 100_000 }
    client.user.index(query: query).parsed_response['users']
  end

  def enrollments
    query = {
      only: %w(category_id user_id grade progress created_at),
      limit: 10
    }
    client.enrollment.index(query: query).parsed_response['enrollments']
  end

  def client
    SkoreAPI::Client.new
  end

  memoize :client, :categories, :users, :enrollments, :items
end
