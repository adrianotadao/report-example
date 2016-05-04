class Report::Item
  extend Memoist
  attr_reader :category_name, :user_name, :started_at, :last_access

  def initialize(enrollment)
    @enrollment = enrollment
  end

  def category_name
    category.name
  end

  def user_name
    user.name
  end

  def started_at
    @enrollment.created_at
  end

  def grade
    @enrollment.grade
  end

  def progress
    @enrollment.progress
  end

  def last_access
    # api not ready
  end

  def completed_lessons
    query = { category_id: category.id, completed_by: user.id, only: %w(id) }
    client.lesson.index(query: query).parsed_response.try(:size).to_i
  end

  def to_a
    [
      category_name,
      user_name,
      started_at,
      grade,
      progress,
      completed_lessons
    ]
  end

  private

  def client
    SkoreAPI::Client.new
  end

  def user
    @enrollment.user
  end

  def category
    @enrollment.category
  end

  memoize :client, :completed_lessons
end
