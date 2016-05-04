module SkoreAPI
  class User < Base
    default_params only: %i(id name email)

    def index(options = {})
      self.class.get('/users', options)
    end

    def show(id, options = {})
      self.class.get("/users/#{ id }", options)
    end
  end
end
