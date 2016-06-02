module SkoreAPI
  class User
    def index(options = {})
      SkoreAPI::Operations::Index.all('/users', options)
    end
  end
end
