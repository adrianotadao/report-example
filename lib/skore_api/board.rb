module SkoreAPI
  class Board
    def index(options = {})
      SkoreAPI::Operations::Index.all('/boards', options)
    end
  end
end
