module SkoreAPI
  class Access < Base
    def index(options = {})
      self.class.get('/accesses', options)
    end
  end
end
