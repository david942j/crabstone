lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'date'

require 'crabstone/version'

Gem::Specification.new do |spec|
  spec.name       = 'crabstone'
  spec.version    = Crabstone::VERSION
  spec.date       = Date.today.to_s
  spec.authors    = ['Ben Nagy', 'david942j']
  spec.license    = 'BSD-3-Clause'
  spec.email      = ['crabstone@ben.iagu.net', 'david942j@gmail.com']
  spec.homepage   = 'https://github.com/david942j/crabstone'
  spec.summary    = 'Ruby FFI bindings for the capstone disassembly engine'
  spec.files      = Dir['lib/**/*.rb']
  spec.description = <<-EOS

  Capstone is a disassembly engine written by Nguyen Anh Quynh, available here
  https://github.com/aquynh/capstone. This is the Ruby FFI binding. We test
  against MRI 2.0.0,  2.1.0 and JRuby 1.7.8. AFAIK it works with rubinius
  2.2.1.

  EOS

  spec.extra_rdoc_files = ['CHANGES.md', 'README.md', 'MANIFEST']

  spec.add_runtime_dependency 'ffi' unless RUBY_PLATFORM =~ /java/

  spec.add_development_dependency 'rake', '~> 12'
  spec.add_development_dependency 'rubocop', '~> 0.63'
end
