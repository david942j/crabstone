# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'date'

require 'crabstone/version'

Gem::Specification.new do |s|
  s.name       = 'crabstone'
  s.version    = Crabstone::VERSION
  s.date       = Date.today.to_s
  s.authors    = ['Ben Nagy', 'david942j']
  s.license    = 'BSD-3-Clause'
  s.email      = ['crabstone@ben.iagu.net', 'david942j@gmail.com']
  s.homepage   = 'https://github.com/david942j/crabstone'
  s.summary    = 'Ruby FFI bindings for the capstone disassembly engine'
  s.files      = Dir['lib/**/*.rb']
  s.description = <<-DES
  Capstone is a disassembly engine written by Nguyen Anh Quynh, available here
  https://github.com/aquynh/capstone. This is the Ruby FFI binding.
  DES

  s.extra_rdoc_files = %w[CHANGES.md README.md LICENSE]
  s.metadata = {
    'bug_tracker_uri' => 'https://github.com/david942j/crabstone/issues',
    'changelog_uri' => 'https://github.com/david942j/crabstone/blob/master/CHANGES.md',
    'documentation_uri' => 'https://www.rubydoc.info/gems/crabstone',
    'homepage_uri' => 'https://github.com/david942j/crabstone',
    'source_code_uri' => 'https://github.com/david942j/crabstone'
  }

  s.required_ruby_version = '>= 2.4'

  s.add_runtime_dependency 'ffi'

  s.add_development_dependency 'rake', '~> 13'
  s.add_development_dependency 'rspec', '~> 3.9'
  s.add_development_dependency 'rubocop', '~> 1'
  s.add_development_dependency 'simplecov', '~> 0.17', '< 0.18'
  s.add_development_dependency 'versionomy', '~> 0.5'
end
