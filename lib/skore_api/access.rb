module SkoreAPI
  class Access
    def index(options = {})
      SkoreAPI::Operations::Index.all('/accesses', options)
    end
  end
end
