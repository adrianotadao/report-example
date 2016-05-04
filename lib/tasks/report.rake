namespace :report do
  desc 'Run Report'
	task :run do
    Report.new.run!
	end
end
