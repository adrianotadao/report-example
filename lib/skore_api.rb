module SkoreAPI
  autoload :Base, './lib/skore_api/base'

  module Operations
    autoload :Base, './lib/skore_api/operations/base'
    autoload :Index, './lib/skore_api/operations/index'
  end

  module Request
    autoload :Collection, './lib/skore_api/request/collection'
  end

  autoload :Access, './lib/skore_api/access'
  autoload :Board, './lib/skore_api/board'
  autoload :Category, './lib/skore_api/category'
  autoload :Department, './lib/skore_api/department'
  autoload :Enrollment, './lib/skore_api/enrollment'
  autoload :Lesson, './lib/skore_api/lesson'
  autoload :User, './lib/skore_api/user'
  autoload :Worksheet, './lib/skore_api/worksheet'

  autoload :Client, './lib/skore_api/client'
end
