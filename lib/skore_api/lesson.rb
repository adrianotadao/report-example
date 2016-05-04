module SkoreAPI
  class Lesson < Base
    default_params only: %i(id title description position permalink board_id
                            content_id cover_id created_at updated_at)

    def index(options = {})
      self.class.get('/lessons', options)
    end

    def show(id, options = {})
      self.class.get("/lessons/#{ id }", options)
    end
  end
end
