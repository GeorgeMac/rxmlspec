# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rxmlspec/version'

Gem::Specification.new do |spec|
  spec.name          = "rxmlspec"
  spec.version       = Rxmlspec::VERSION
  spec.authors       = ["George MacRorie"]
  spec.email         = ["gmacr31@gmail.com"]
  spec.description   = %q{Ruby XML Spec DSL}
  spec.summary       = %q{Ruby gem for validating xml documents using a simple DSL}
  spec.homepage      = "http://github.com/GeorgeMac/rxmlspec"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
