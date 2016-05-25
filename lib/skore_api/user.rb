module SkoreAPI
  class User < Base
    def index(options = {})
      self.class.get('/users', options)
    end
  end
end
