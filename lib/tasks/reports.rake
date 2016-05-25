namespace :reports do
  desc 'Enrollments Report'
  task :enrollments do
    Reports::Enrollments::Report.new.run!
  end

  desc 'Users Report'
  task :users do
    Reports::Users::Report.new.run!
  end

  desc 'Departments Report'
  task :departments do
    Reports::Departments::Report.new.run!
  end

  desc 'Worksheets Report'
  task :worksheets do
    Reports::Worksheets::Report.new.run!
  end
end
