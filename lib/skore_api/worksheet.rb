module SkoreAPI
  class Worksheet < Base
    def index(options = {})
      self.class.get('/worksheets', options)
    end
  end
end
