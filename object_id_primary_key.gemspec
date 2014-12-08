# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'object_id_primary_key/version'

Gem::Specification.new do |spec|
  spec.name          = "object_id_primary_key"
  spec.version       = ObjectIdPrimaryKey::VERSION
  spec.authors       = ["Matt Pokress"]
  spec.email         = ["mpokress@pillpack.com"]
  spec.summary       = %q{ObjectID Primary Keys for ActiveRecord models}
  spec.description   = %q{Replaces the standard AR autoincrement IDs with ObjectIDs}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'bson', '~> 2.3.0'
  spec.add_development_dependency 'rails', '~> 4.0.0'
  spec.add_development_dependency 'rspec-rails', '~> 3.0'
  spec.add_development_dependency 'sqlite3', '~> 1.0'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
