module SkoreAPI
  class Client
    extend Memoist

    def initialize(access_token = ENV['SKORE_TOKEN'])
      @access_token = access_token
    end

    def access
      SkoreAPI::Access.new(@access_token)
    end

    def board
      SkoreAPI::Board.new(@access_token)
    end

    def category
      SkoreAPI::Category.new(@access_token)
    end

    def enrollment
      SkoreAPI::Enrollment.new(@access_token)
    end

    def lesson
      SkoreAPI::Lesson.new(@access_token)
    end

    def user
      SkoreAPI::User.new(@access_token)
    end

    memoize :access, :board, :category, :enrollment, :lesson, :user
  end
end
