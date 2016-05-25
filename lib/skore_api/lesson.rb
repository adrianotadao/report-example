module SkoreAPI
  class Lesson < Base
    def index(options = {})
      self.class.get('/lessons', options)
    end
  end
end
