module SkoreAPI
  class Client
    extend Memoist

    def initialize(access_token = ENV['SKORE_TOKEN'])
      @access_token = access_token
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

    memoize :board, :category, :enrollment, :lesson
  end
end
