module SkoreAPI
  class Enrollment
    def index(options = {})
      SkoreAPI::Operations::Index.all('/enrollments', options)
    end
  end
end
