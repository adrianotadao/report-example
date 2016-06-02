module SkoreAPI
  class Department
    def index(options = {})
      SkoreAPI::Operations::Index.all('/departments', options)
    end
  end
end
