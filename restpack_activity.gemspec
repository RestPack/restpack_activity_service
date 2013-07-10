# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'restpack_activity/version'

Gem::Specification.new do |spec|
  spec.name          = "restpack_activity"
  spec.version       = RestPack::Activity::VERSION
  spec.authors       = ["Gavin Joyce"]
  spec.email         = ["gavinjoyce@gmail.com"]
  spec.description   = %q{RestPack Activity Services}
  spec.summary       = %q{Simple Activity Streams}
  spec.homepage      = "https://github.com/RestPack"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "standalone_migrations",  "~> 2.1.1"
  spec.add_dependency "restpack_serializer",    "~> 0.2.14"
  spec.add_dependency "mutations",              "~> 0.6.0"
  spec.add_dependency "pg",                     "~> 0.15.1"
  spec.add_dependency "postgres_ext",           "~> 0.4.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "database_cleaner", "~> 1.0.1"
  spec.add_development_dependency "rspec"
  # spec.add_development_dependency "minitest-reporters", "~> 0.14.20"
  # spec.add_development_dependency "minitest-implicit-subject"
end
