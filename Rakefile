# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

# Edit Rakefile in project root
#
# Add a new rake test task... E.g., rake test:lib, below everything else in that file...
# Alternatively, add a task in lib/tasks/ directory and plop in the same code
namespace :test do
	desc "Test lib source"
	Rake::TestTask.new(:lib) do |t|
		t.libs << "test"
		t.pattern = 'test/lib/**/*_test.rb'
		t.verbose = true
	end

	desc "Test repositories"
	Rake::TestTask.new(:repos) do |t|
		t.libs << "test"
		t.pattern = 'test/repositories/**/*_test.rb'
		t.verbose = true
	end
 
end
 
repo_task = Rake::Task["test:repos"]
test_task = Rake::Task[:test]
test_task.enhance { repo_task.invoke }

lib_task = Rake::Task["test:lib"]
test_task = Rake::Task[:test]
test_task.enhance { lib_task.invoke }
