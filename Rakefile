require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop/rake_task'

import 'tasks/gen_arch.rake'
import 'tasks/gen_binding.rake'

Rake::TestTask.new do |t|
  t.verbose = true
  t.warning = true
end

RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb', 'examples/*.rb', 'tasks/**/*.{rake,rb}']
end

task default: %i[rubocop test]
