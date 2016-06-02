namespace :reports do
  desc 'Accesses Report'
  task :accesses do
    Reports::Accesses::Report.new.run!
  end

  desc 'Departments Report'
  task :departments do
    Reports::Departments::Report.new.run!
  end

  desc 'Enrollments Report'
  task :enrollments do
    Reports::Enrollments::Report.new.run!
  end

  desc 'Users Report'
  task :users do
    Reports::Users::Report.new.run!
  end

  desc 'User Departmetns Report'
  task :user_departments do
    Reports::UserDepartments::Report.new.run!
  end

  desc 'Worksheets Report'
  task :worksheets do
    Reports::Worksheets::Report.new.run!
  end
end
