module SkoreAPI
  class Board < Base
    default_params only: %i(id name description category_id position permalink
                            background_image_id created_at updated_at)

    def index(options = {})
      self.class.get('/boards', options)
    end

    def show(id, options = {})
      self.class.get("/boards/#{ id }", options)
    end
  end
end
