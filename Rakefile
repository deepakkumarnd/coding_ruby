require 'rubocop/rake_task'

task default: %w[lint test]

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = %w[src/**/*.rb test/**/*.rb]
  task.fail_on_error = false
end

desc 'Run'
task :run do
  ruby 'src/hello.rb'
end

desc 'Run all tests'
task :test do
  ruby 'test/hello_test.rb'
end