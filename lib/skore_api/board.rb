module SkoreAPI
  class Board < Base
    def index(options = {})
      self.class.get('/boards', options)
    end
  end
end
