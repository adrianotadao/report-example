class Report
  extend Memoist

  autoload :Item, './lib/report/item'

  def run!
    items.each do |item|
      p item.to_a
    end
    byebug
  end

  private

  def items
    enrollments.map { |enrollment| Report::Item.new(enrollment) }
  end

  def enrollments
    query = {
      only: %w(category.id category.name user.id user.name grade progress created_at),
      limit: 10
    }
    client.enrollment.index(query: query).parsed_response['enrollments']
  end

  def client
    SkoreAPI::Client.new
  end

  memoize :client, :enrollments, :items
end
