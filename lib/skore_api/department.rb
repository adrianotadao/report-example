module SkoreAPI
  class Department < Base
    def index(options = {})
      self.class.get('/departments', options)
    end
  end
end
