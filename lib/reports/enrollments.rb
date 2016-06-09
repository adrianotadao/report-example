module Reports
  module Enrollments
    autoload :Finders, "#{ ROOT }/lib/reports/enrollments/finders"
    autoload :Item, "#{ ROOT }/lib/reports/enrollments/item"
    autoload :Report, "#{ ROOT }/lib/reports/enrollments/report"
  end
end
