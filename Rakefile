require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

import 'tasks/generate/all.rake'

RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb', 'spec/**/*.rb', 'examples/*.rb', 'tasks/**/*.{rake,rb}']
end

RSpec::Core::RakeTask.new(:spec)

task default: %i[rubocop spec]
