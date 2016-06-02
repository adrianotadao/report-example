module SkoreAPI
  class Lesson
    def index(options = {})
      SkoreAPI::Operations::Index.all('/lessons', options)
    end
  end
end
