module SkoreAPI
  class Category
    def index(options = {})
      SkoreAPI::Operations::Index.all('/categories', options)
    end
  end
end
