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
  https://github.com/aquynh/capstone. This is the Ruby FFI binding. We test
  against MRI 2.0.0,  2.1.0 and JRuby 1.7.8. AFAIK it works with rubinius
  2.2.1.

  DES

  s.extra_rdoc_files = %w[CHANGES.md README.md LICENSE]

  s.required_ruby_version = '>= 2.3'

  s.add_runtime_dependency 'ffi' unless RUBY_PLATFORM =~ /java/

  s.add_development_dependency 'rake', '~> 12'
  s.add_development_dependency 'rspec', '~> 3.8'
  s.add_development_dependency 'rubocop', '~> 0.63'
  s.add_development_dependency 'simplecov', '~> 0.16'
  s.add_development_dependency 'versionomy', '~> 0.5'
end
