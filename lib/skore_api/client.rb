module SkoreAPI
  class Client
    extend Memoist

    def access
      SkoreAPI::Access.new
    end

    def board
      SkoreAPI::Board.new
    end

    def category
      SkoreAPI::Category.new
    end

    def department
      SkoreAPI::Department.new
    end

    def enrollment
      SkoreAPI::Enrollment.new
    end

    def lesson
      SkoreAPI::Lesson.new
    end

    def user
      SkoreAPI::User.new
    end

    def worksheet
      SkoreAPI::Worksheet.new
    end

    memoize :access, :board, :category, :department, :enrollment, :lesson, :user, :worksheet
  end
end
