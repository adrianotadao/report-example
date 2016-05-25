module SkoreAPI
  class Enrollment < Base
    def index(options = {})
      self.class.get('/enrollments', options)
    end
  end
end
