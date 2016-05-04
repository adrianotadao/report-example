module SkoreAPI
  class Access < Base
    default_params only: %i(id lesson_id user_id created_at)

    def index(options = {})
      self.class.get('/accesses', options)
    end

    def show(id, options = {})
      self.class.get("/accesses/#{ id }", options)
    end
  end
end
