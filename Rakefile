require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

import 'tasks/gen_arch.rake'
import 'tasks/gen_binding.rake'

Rake::TestTask.new do |t|
  t.verbose = true
  t.warning = true
end

RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb', 'spec/**/*.rb', 'examples/*.rb', 'tasks/**/*.{rake,rb}']
end

RSpec::Core::RakeTask.new(:spec) do |task|
  task.pattern = './spec/**/*_spec.rb'
  task.rspec_opts = ['--color', '--require spec_helper', '--order rand']
end

task default: %i[rubocop test]
