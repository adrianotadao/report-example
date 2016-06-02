module SkoreAPI
  class Worksheet
    def index(options = {})
      SkoreAPI::Operations::Index.all('/worksheets', options)
    end
  end
end
