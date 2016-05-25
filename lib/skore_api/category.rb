module SkoreAPI
  class Category < Base
    def index(options = {})
      self.class.get('/categories', options)
    end
  end
end
