module SkoreAPI
  class Enrollment < Base
    default_params only: %i(id user_id category_id progress grade created_at updated_at)

    def index(options = {})
      self.class.get('/enrollments', options)
    end

    def show(id, options = {})
      self.class.get("/enrollments/#{ id }", options)
    end
  end
end
