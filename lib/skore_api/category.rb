module SkoreAPI
  class Category < Base
    default_params only: %i(id name template description permalink created_at updated_at)

    def index(options = {})
      self.class.get('/categories', options)
    end

    def show(id, options = {})
      self.class.get("/categories/#{ id }", options)
    end
  end
end
